<?php

namespace Tests\Unit;

use App\Models\User;
use App\Models\Role;
use App\Models\Permission;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
use PHPUnit\Framework\Attributes\Test;

class RolePermissionTest extends TestCase
{
    use RefreshDatabase;

    public function setUp(): void
    {
        parent::setUp();
        $this->artisan('db:seed', ['--class' => 'LanguageSeeder']);
        $this->artisan('db:seed', ['--class' => 'RolePermissionSeeder']);
    }

    #[Test]
    public function user_can_be_assigned_role()
    {
        $user = User::first();
        $role = Role::find(1);

        $user->assignRole($role);

        $this->assertTrue($user->hasRole('Admin'));
    }

    #[Test]
    public function user_has_permission_through_role()
    {
        $user = User::first();

        $this->assertTrue($user->hasPermissionTo('Edit Users'));
    }

    #[Test]
    public function role_has_correct_permission()
    {
        $role = Role::find(1);

        $this->assertTrue($role->hasPermissionTo('Edit Users'));
    }
}