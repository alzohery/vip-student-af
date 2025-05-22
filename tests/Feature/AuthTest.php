<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\Role;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class AuthTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();

        // Seed languages first, then roles and users
        $this->artisan('db:seed', ['--class' => 'LanguageSeeder']);
        $this->artisan('db:seed', ['--class' => 'CitySeeder']);
        $this->artisan('db:seed', ['--class' => 'RolePermissionSeeder']);
        $this->artisan('db:seed', ['--class' => 'RoleSeeder']);
        $this->artisan('db:seed', ['--class' => 'UserSeeder']);
    }

    public function test_it_can_register_a_new_user()
    {
        $response = $this->postJson('/api/auth/register', [
            'name' => 'New User',
            'email' => 'newuser@vipstudent.com',
            'password' => 'password123',
            'password_confirmation' => 'password123',
            'role_id' => 1,
            'birthdate' => '1995-05-15',
            'phone' => '+201234567890',
            'country' => 'Egypt',
            'timezone' => 'Africa/Cairo',
        ], ['Accept-Language' => 'ar']);

        $response->assertStatus(201)
                 ->assertJson([
                     'message' => 'تم التسجيل بنجاح',
                     'user' => [
                         'name' => 'New User',
                         'email' => 'newuser@vipstudent.com',
                     ],
                     'token' => true,
                 ]);

        $this->assertDatabaseHas('users', [
            'email' => 'newuser@vipstudent.com',
            'name' => 'New User',
        ]);
    }

    public function test_it_fails_to_register_with_duplicate_email()
{
    User::factory()->create([
        'email' => 'existing@vipstudent.com',
        'password' => Hash::make('password123'),
        'role_id' => 1,
    ]);

    $response = $this->postJson('/api/auth/register', [
        'name' => 'Test User',
        'email' => 'existing@vipstudent.com',
        'password' => 'password123',
        'password_confirmation' => 'password123',
        'role_id' => 1,
    ], ['Accept-Language' => 'ar']);

    $response->assertStatus(422)
             ->assertJson([
                 'error' => [
                     'email' => ['البريد الإلكتروني مستخدم بالفعل.'],
                 ],
             ]);
}

    public function test_it_can_login_with_valid_credentials()
    {
        $response = $this->postJson('/api/auth/login', [
            'email' => 'admin@vipstudent.com',
            'password' => 'password',
        ], ['Accept-Language' => 'ar']);

        $response->assertStatus(200)
                 ->assertJson([
                     'message' => 'تم تسجيل الدخول بنجاح',
                     'user' => [
                         'email' => 'admin@vipstudent.com',
                     ],
                     'token' => true,
                 ]);
    }

    public function test_it_fails_to_login_with_invalid_credentials()
    {
        $response = $this->postJson('/api/auth/login', [
            'email' => 'wrong@vipstudent.com',
            'password' => 'wrong',
        ], ['Accept-Language' => 'ar']);

        $response->assertStatus(401)
                 ->assertJson([
                     'error' => 'بيانات الاعتماد هذه لا تتطابق مع سجلاتنا.',
                 ]);
    }

    public function test_it_returns_english_validation_messages()
    {
        $response = $this->postJson('/api/auth/register', [
            'name' => 'Test User',
            'email' => 'admin@vipstudent.com',
            'password' => 'password123',
            'password_confirmation' => 'password123',
            'role_id' => 1,
        ], ['Accept-Language' => 'en']);

        $response->assertStatus(422)
                 ->assertJson([
                     'error' => [
                         'email' => ['The email has already been taken.'],
                     ],
                 ]);
    }

    public function test_it_fails_to_register_with_invalid_role_id()
    {
        $response = $this->postJson('/api/auth/register', [
            'name' => 'New User',
            'email' => 'newuser@vipstudent.com',
            'password' => 'password123',
            'password_confirmation' => 'password123',
            'role_id' => 999, // Non-existent role_id
        ], ['Accept-Language' => 'ar']);

        $response->assertStatus(422)
                 ->assertJson([
                     'error' => [
                         'role_id' => ['الحقل الدور المختار غير صالح.'],
                     ],
                 ]);
    }
}