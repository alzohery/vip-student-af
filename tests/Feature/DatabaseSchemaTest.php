<?php
namespace Tests\Feature;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
class DatabaseSchemaTest extends TestCase
{
    use RefreshDatabase;

    public function test_languages_table_exists()
    {
        $this->assertTrue(\Schema::hasTable('languages'));
        $this->assertTrue(\Schema::hasColumn('languages', 'code'));
    }
    public function test_cities_table_exists()
    {
        $this->assertTrue(\Schema::hasTable('cities'));
    }
    public function test_city_translations_table_exists()
    {
        $this->assertTrue(\Schema::hasTable('city_translations'));
        $this->assertTrue(\Schema::hasColumn('city_translations', 'name'));
    }
    public function test_roles_table_exists()
    {
        $this->assertTrue(\Schema::hasTable('roles'));
    }
    public function test_users_table_exists()
    {
        $this->assertTrue(\Schema::hasTable('users'));
    }
    public function test_language_seeder_works()
    {
        $this->seed(\Database\Seeders\LanguageSeeder::class);
        $this->assertDatabaseHas('languages', ['code' => 'en', 'name' => 'English']);
    }
    public function test_city_seeder_works()
    {
        $this->seed(\Database\Seeders\CitySeeder::class);
        $this->assertDatabaseHas('city_translations', ['locale' => 'ar', 'name' => 'القاهرة']);
    }
    // public function test_role_seeder_works()
    // {
    //     $this->seed(\Database\Seeders\RoleSeeder::class);
    //     $this->assertDatabaseHas('role_translations', ['locale' => 'en', 'name' => 'Admin']);
    // }

    public function test_role_seeder_works()
    {
        // شغّل LanguageSeeder الأول
        $this->artisan('db:seed', ['--class' => 'LanguageSeeder']);
        // شغّل RoleSeeder بعديه
        $this->artisan('db:seed', ['--class' => 'RoleSeeder']);
        $this->assertDatabaseHas('roles', ['slug' => 'admin']);
        $this->assertDatabaseHas('role_translations', ['locale' => 'en', 'name' => 'Admin']);
    }
    public function test_user_seeder_works()
    {
        $this->seed(\Database\Seeders\DatabaseSeeder::class);
        $this->assertDatabaseHas('users', ['email' => 'admin@vipstudent.com']);
    }
}