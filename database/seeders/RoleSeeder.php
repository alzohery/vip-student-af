<?php
namespace Database\Seeders;
use Illuminate\Database\Seeder;
use App\Models\Role;
use App\Models\RoleTranslation;
use App\Models\Language;
use Carbon\Carbon;

class RoleSeeder extends Seeder
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

        // إنشاء دور 1
        $role = Role::create([
            'level' => 1,
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);

        foreach (['ar' => 'مدير', 'en' => 'Admin'] as $locale => $name) {
            if (in_array($locale, $languages)) {
                RoleTranslation::create([
                    'role_id' => $role->id,
                    'locale' => $locale,
                    'name' => $name,
                    'created_at' => Carbon::now(),
                    'updated_at' => Carbon::now(),
                ]);
            }
        }

        // إنشاء دور 2
        $role2 = Role::create([
            'level' => 2,
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);

        foreach (['ar' => 'مدرب', 'en' => 'Instructor'] as $locale => $name) {
            if (in_array($locale, $languages)) {
                RoleTranslation::create([
                    'role_id' => $role2->id,
                    'locale' => $locale,
                    'name' => $name,
                    'created_at' => Carbon::now(),
                    'updated_at' => Carbon::now(),
                ]);
            }
        }

        // إنشاء دور 3
        $role3 = Role::create([
            'level' => 3,
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);

        foreach (['ar' => 'طالب', 'en' => 'Student'] as $locale => $name) {
            if (in_array($locale, $languages)) {
                RoleTranslation::create([
                    'role_id' => $role3->id,
                    'locale' => $locale,
                    'name' => $name,
                    'created_at' => Carbon::now(),
                    'updated_at' => Carbon::now(),
                ]);
            }
        }
    }
}