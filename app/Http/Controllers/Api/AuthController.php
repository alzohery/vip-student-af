<?php

namespace App\Http\Controllers\Api;

use App\Models\Role;
use App\Models\User;
use App\Models\City;
use App\Models\CityTranslation;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Password; 
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\Controller;
use Rinvex\Country\CountryLoader;
use Rinvex\Country\Country;
use Illuminate\Support\Str;
use Illuminate\Auth\Events\PasswordReset;

use App\Models\AuditLog;
use App\Models\AuditLogTranslation;

class AuthController extends Controller
{
    /**
     * Register a new user
     */
    public function register(Request $request)
    {
        // التحقق من الحقول
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
            'role_slug' => 'required|string|exists:roles,slug',
            'birthdate' => 'nullable|date',
            'phone' => 'nullable|string|max:20',
            'country' => 'required|string|max:255',
            'city' => 'nullable|string|max:100',
            'zip_code' => [
                'nullable',
                'string',
                'max:20',
                function ($attribute, $value, $fail) use ($request) {
                    $country = $request->country;
                    if (!$country || !$value) {
                        return;
                    }

                    $zipFormats = [
                        'Egypt' => '/^\d{5}$/',
                        'United States' => '/^\d{5}(-\d{4})?$/',
                        'United Kingdom' => '/^[A-Z]{1,2}\d{1,2}[A-Z]?\s?\d[A-Z]{2}$/',
                    ];

                    $countryName = $this->normalizeCountryName($country);
                    if (isset($zipFormats[$countryName])) {
                        if (!preg_match($zipFormats[$countryName], $value)) {
                            $fail(__('validation.invalid_zip_code', ['country' => $country]));
                        }
                    } else {
                        if (!preg_match('/^\w{3,20}$/', $value)) {
                            $fail(__('validation.invalid_zip_code_generic'));
                        }
                    }
                },
            ],
            'timezone' => 'required|string|max:50',
        ], [], [
            'role_slug' => __('validation.attributes.role'),
            'country' => __('validation.attributes.country'),
            'city' => __('validation.attributes.city'),
            'zip_code' => __('validation.attributes.zip_code'),
            'timezone' => __('validation.attributes.timezone'),
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 422);
        }

        // تحميل الدول مع التخزين المؤقت
        $countries = cache()->remember('countries', now()->addHours(24), function () {
            $rawCountries = CountryLoader::countries();
            return collect($rawCountries)->map(fn($data) => new Country($data));
        });

        // تحميل aliases من ملف JSON
        $countryAliases = $this->loadCountryAliases();

        // تعيين الدولة بعد التطبيع بناءً على aliases
        $normalizedCountry = $countryAliases[Str::lower($request->country)] ?? $request->country;

        // البحث عن الدولة
        $countryMatch = $countries->first(function ($country) use ($normalizedCountry) {
            $inputCountry = Str::lower($normalizedCountry);
            return Str::lower($country->getName('en')) === $inputCountry
                || Str::lower($country->getName('ar')) === $inputCountry
                || Str::contains(Str::lower($country->getName('ar')), $inputCountry)
                || Str::contains(Str::lower($country->getName('en')), $inputCountry)
                || $country->getIsoAlpha2() === strtoupper($normalizedCountry)
                || $country->getIsoAlpha3() === strtoupper($normalizedCountry);
        });

        if (!$countryMatch) {
            return response()->json(['error' => ['country' => [__('validation.invalid_country')]]], 422);
        }

        // التحقق من التوقيت الزمني
        if (!in_array($request->timezone, $countryMatch->getTimezones())) {
            return response()->json(['error' => ['timezone' => [__('validation.invalid_timezone_for_country')]]], 422);
        }

        // التحقق من المدينة واستخراج city_id
        $cityId = null;
        if ($request->city) {
            $cityTranslation = CityTranslation::where('name', $request->city)
                ->where('locale', app()->getLocale())
                ->first();

            if (!$cityTranslation) {
                return response()->json(['error' => ['city' => [__('validation.invalid_city')]]], 422);
            }

            $cityId = $cityTranslation->city_id;
        }

        // البحث عن الدور
        $role = Role::where('slug', $request->role_slug)->firstOrFail();

        // إنشاء المستخدم
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role_id' => $role->id,
            'birthdate' => $request->birthdate,
            'phone' => $request->phone,
            'country' => $countryMatch->getName('en'),
            'city_id' => $cityId,
            'zip_code' => $request->zip_code,
            'timezone' => $request->timezone,
        ]);

        // تعيين الدور باستخدام Spatie Permission
        $user->assignRole($role);

        // توليد التوكن
        $token = $user->createToken('auth_token', ['user:read', 'user:update'])->plainTextToken;

        // إعداد بيانات المستخدم
        $userData = [
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
            'birthdate' => $user->birthdate,
            'phone' => $user->phone,
            'country' => $user->country,
            'city_id' => $user->city_id,
            'city_name' => $request->city,
            'zip_code' => $user->zip_code,
            'timezone' => $user->timezone,
            'slug' => $user->role ? $user->role->slug : null,
        ];

        return response()->json([
            'message' => __('auth.register_success'),
            'user' => $userData,
            'token' => $token,
        ], 201);
    }

    /**
     * تحميل aliases من ملف JSON مع تخزين مؤقت
     */
    protected function loadCountryAliases()
    {
        return cache()->remember('country_aliases', now()->addHours(24), function () {
            $path = resource_path('json/country_aliases.json');
            if (!file_exists($path)) {
                return [];
            }
            $data = json_decode(file_get_contents($path), true);
            $aliases = [];
            foreach ($data['countries'] as $country) {
                $aliases[Str::lower($country['arabic'])] = $country['english'];
                $aliases[Str::lower($country['english'])] = $country['english'];
            }
            return $aliases;
        });
    }

    /**
     * Get list of countries
     */
    public function getCountries(Request $request)
    {
        // تحميل الدول من ملف JSON
        $countriesData = json_decode(file_get_contents(resource_path('json/country_aliases.json')), true)['countries'];

        // تحميل الدول من rinvex/country لإضافة iso_alpha2 و iso_alpha3
        $countries = cache()->remember('countries', now()->addHours(24), function () {
            $rawCountries = CountryLoader::countries();
            return collect($rawCountries)->map(fn($data) => new Country($data));
        });

        // دمج البيانات مع iso_alpha2 و iso_alpha3
        $countryList = collect($countriesData)->map(function ($country) use ($countries) {
            $rinvexCountry = $countries->first(fn($c) => Str::lower($c->getName('en')) === Str::lower($country['english']));
            return [
                'name_en' => $country['english'],
                'name_ar' => $country['arabic'],
                'iso_alpha2' => $rinvexCountry ? $rinvexCountry->getIsoAlpha2() : null,
                'iso_alpha3' => $rinvexCountry ? $rinvexCountry->getIsoAlpha3() : null,
            ];
        })->values()->toArray();

        return response()->json([
            'message' => __('countries.retrieved_success'),
            'countries' => $countryList,
        ], 200);
    }

    /**
     * Get list of timezones
     */
    public function getTimezones(Request $request)
    {
        // استرجاع المناطق الزمنية مع التخزين المؤقت
        $timezones = cache()->remember('timezones', now()->addHours(24), function () {
            return \DateTimeZone::listIdentifiers(\DateTimeZone::ALL);
        });

        return response()->json([
            'message' => __('timezones.retrieved_success'),
            'timezones' => array_values($timezones),
        ], 200);
    }

    /**
     * Normalize country name for zip code validation
     */
    protected function normalizeCountryName($country)
    {
        // تحميل aliases من ملف JSON
        $countryAliases = $this->loadCountryAliases();

        // تطبيع اسم الدولة
        $normalizedCountry = $countryAliases[Str::lower($country)] ?? $country;

        // تحميل الدول من rinvex/country
        $countries = cache()->remember('countries', now()->addHours(24), function () {
            $rawCountries = CountryLoader::countries();
            return collect($rawCountries)->map(fn($data) => new Country($data));
        });

        $countryMatch = $countries->first(function ($c) use ($normalizedCountry) {
            $inputCountry = Str::lower($normalizedCountry);
            return Str::lower($c->getName('en')) === $inputCountry
                || Str::lower($c->getName('ar')) === $inputCountry
                || Str::contains(Str::lower($c->getName('ar')), $inputCountry)
                || Str::contains(Str::lower($c->getName('en')), $inputCountry)
                || $c->getIsoAlpha2() === strtoupper($normalizedCountry)
                || $c->getIsoAlpha3() === strtoupper($normalizedCountry);
        });

        return $countryMatch ? $countryMatch->getName('en') : $country;
    }








    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 422);
        }

        
        $user = User::where('email', $request->email)->first();
        $user->update(['last_login_at' => now()]);

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json(['error' => __('auth.failed')], 401);
        }

        $token = $user->createToken('auth_token')->plainTextToken;

        // get user data
        $userData = $user->toArray();

        // get only sulg from role slug
        $userData['slug'] = $user->role ? $user->role->slug : null;

        // لو كان الـ userData يحتوي على مفتاح role، نحذفه حتى لا تظهر التفاصيل الكاملة
        unset($userData['role']);

        

        return response()->json([
            'message' => __('auth.login_success'),
            'user' => $userData,
            'token' => $token,
        ]);
    }



    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return response()->json(['message' => __('auth.logged_out')], 200);
    }


    public function updateProfile(Request $request)
    {
        $user = $request->user();

        $validator = Validator::make($request->all(), [
            'name' => 'sometimes|string|max:100',
            'email' => 'sometimes|email|max:255|unique:users,email,' . $user->id,
            'phone' => 'sometimes|nullable|string|max:20',
            'birthdate' => 'sometimes|nullable|date',
            'city_id' => 'sometimes|nullable|exists:cities,id',
            'country' => 'sometimes|nullable|string|max:100',
            'zip_code' => 'sometimes|nullable|string|max:20',
            'timezone' => 'sometimes|nullable|string|max:50',
            'profile_picture' => 'sometimes|nullable|string|max:255',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => __('auth.validation_failed'),
                'errors' => $validator->errors()
            ], 422);
        }

        $user->update($validator->validated());
        // $user->fill($validator->validated());
        // $user->save();

        return response()->json([
            'message' => __('auth.profile_updated'),
            'user' => new UserResource($user)
        ], 200);
    }


    public function forgotPassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email|exists:users,email',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => __('auth.validation_failed'),
                'errors' => $validator->errors()
            ], 422);
        }

        $status = Password::sendResetLink(
            $request->only('email')
        );

        return $status === Password::RESET_LINK_SENT
            ? response()->json(['message' => __($status)], 200)
            : response()->json(['message' => __($status)], 400);
    }

    public function resetPassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'token' => 'required',
            'email' => 'required|email|exists:users,email',
            'password' => 'required|string|min:8|confirmed',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => __('auth.validation_failed'),
                'errors' => $validator->errors()
            ], 422);
        }

        $status = Password::reset(
            $request->only('email', 'password', 'password_confirmation', 'token'),
            function ($user, $password) use ($request) {
                $oldPassword = $user->password;
                $user->forceFill([
                    'password' => Hash::make($password)
                ]);
                // ->setRememberToken(Str::random(60))
                $user->save();

                // تسجيل التغيير في audit_logs
                $auditLog = AuditLog::create([
                    'table_name' => 'users',
                    'record_id' => $user->id,
                    'changed_by' => $user->id, // المستخدم نفسه
                    'changed_at' => now(),
                ]);

                // تسجيل الترجمة للإجراء
                $locales = ['ar', 'en'];
                foreach ($locales as $locale) {
                    AuditLogTranslation::create([
                        'audit_log_id' => $auditLog->id,
                        'locale' => $locale,
                        'action' => $locale === 'ar' ? 'إعادة تعيين كلمة المرور' : 'Password reset',
                        'old_value' => $oldPassword,
                        'new_value' => Hash::make($password),
                    ]);
                }

                event(new PasswordReset($user));
            }
        );

        return $status === Password::PASSWORD_RESET
            ? response()->json(['message' => __($status)], 200)
            : response()->json(['message' => __($status)], 400);
    }

}