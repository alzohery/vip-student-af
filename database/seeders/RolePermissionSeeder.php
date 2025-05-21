<?php

namespace Database\Seeders;

use App\Models\Role;
use App\Models\Permission;
use App\Models\User;
use Illuminate\Database\Seeder;

class RolePermissionSeeder extends Seeder
{
    public function run()
    {
        // Create or update role
        $role = Role::updateOrCreate(
            [
                'id' => 1,
                'guard_name' => 'web',
            ],
            [
                'level' => 1,
                'guard_name' => 'web',
            ]
        );
        $role->translateOrNew('en')->name = 'Admin';
        $role->translateOrNew('ar')->name = 'مدير';
        $role->save();

        // Create or update permission
        $permission = Permission::updateOrCreate(
            [
                'id' => 3,
                'guard_name' => 'web',
            ],
            [
                'guard_name' => 'web',
            ]
        );
        $permission->translateOrNew('en')->name = 'Edit Users';
        $permission->translateOrNew('ar')->name = 'تعديل المستخدمين';
        $permission->save();

        // Attach permission to role
        $role->permissions()->sync([3]);

        // Create or update user
        if (!User::where('email', 'admin@vipstudent.com')->exists()) {
            $user = User::firstOrCreate(
                ['email' => 'admin@vipstudent.com'],
                [
                    'name' => 'Admin User',
                    'password' => bcrypt('password'),
                    'role_id' => 1,
                ]
            );
        }
        // Assign role to user
        $user->assignRole($role);
    }
}