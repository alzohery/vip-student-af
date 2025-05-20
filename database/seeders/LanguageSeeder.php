<?php
namespace Database\Seeders;
use Illuminate\Database\Seeder;
use App\Models\Language;
class LanguageSeeder extends Seeder
{
    public function run()
    {
        Language::updateOrCreate([
            'code' => 'en',
            'name' => 'English',
            'is_default' => 1,
        ]);
        Language::updateOrCreate([
            'code' => 'ar',
            'name' => 'العربية',
            'is_default' => 0,
        ]);
    }
}