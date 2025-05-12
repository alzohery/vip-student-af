<?php
namespace Database\Seeders;
use Illuminate\Database\Seeder;
use App\Models\City;
use App\Models\CityTranslation;
use App\Models\Language;
use Carbon\Carbon;

class CitySeeder extends Seeder
{
    public function run(): void
    {
        // التأكد من وجود اللغات
        $languages = Language::pluck('code')->toArray();
        if (empty($languages)) {
            // تشغيل LanguageSeeder إذا لم تكن اللغات موجودة
            $this->call(LanguageSeeder::class);
            $languages = Language::pluck('code')->toArray();
        }

        // إنشاء مدينة 1
        $city = City::create([
            'country_id' => null,
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);

        foreach (['ar' => 'القاهرة', 'en' => 'Cairo'] as $locale => $name) {
            if (in_array($locale, $languages)) {
                CityTranslation::create([
                    'city_id' => $city->id,
                    'locale' => $locale,
                    'name' => $name,
                    'created_at' => Carbon::now(),
                    'updated_at' => Carbon::now(),
                ]);
            }
        }

        // إنشاء مدينة 2
        $city2 = City::create([
            'country_id' => null,
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);

        foreach (['ar' => 'الرياض', 'en' => 'Riyadh'] as $locale => $name) {
            if (in_array($locale, $languages)) {
                CityTranslation::create([
                    'city_id' => $city2->id,
                    'locale' => $locale,
                    'name' => $name,
                    'created_at' => Carbon::now(),
                    'updated_at' => Carbon::now(),
                ]);
            }
        }
    }
}