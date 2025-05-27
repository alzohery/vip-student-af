<?php

namespace Database\Seeders;

use App\Models\Role;
use App\Models\Permission;
use Illuminate\Database\Seeder;

class RolePermissionSeeder extends Seeder
{
    public function run()
    {
        // Create or update Admin role
        $adminRole = Role::updateOrCreate(
            ['id' => 1, 'guard_name' => 'api'],
            ['level' => 1, 'guard_name' => 'api', 'slug' => 'admin']
        );
        $adminRole->translations()->firstOrCreate(['locale' => 'en', 'name' => 'Admin']);
        $adminRole->translations()->firstOrCreate(['locale' => 'ar', 'name' => 'مدير']);

        // Create or update Guardian role
        $guardianRole = Role::updateOrCreate(
            ['id' => 2, 'guard_name' => 'api'],
            ['level' => 2, 'guard_name' => 'api', 'slug' => 'guardian']
        );
        $guardianRole->translations()->firstOrCreate(['locale' => 'en', 'name' => 'Guardian']);
        $guardianRole->translations()->firstOrCreate(['locale' => 'ar', 'name' => 'ولي الأمر']);

        // Create or update Student role
        $studentRole = Role::updateOrCreate(
            ['id' => 3, 'guard_name' => 'api'],
            ['level' => 3, 'guard_name' => 'api', 'slug' => 'student']
        );
        $studentRole->translations()->firstOrCreate(['locale' => 'en', 'name' => 'Student']);
        $studentRole->translations()->firstOrCreate(['locale' => 'ar', 'name' => 'طالب']);

        // Create or update Teacher role
        $teacherRole = Role::updateOrCreate(
            ['id' => 4, 'guard_name' => 'api'],
            ['level' => 4, 'guard_name' => 'api', 'slug' => 'teacher']
        );
        $teacherRole->translations()->firstOrCreate(['locale' => 'en', 'name' => 'Teacher']);
        $teacherRole->translations()->firstOrCreate(['locale' => 'ar', 'name' => 'معلم']);

        // Create or update Institute role
        $instituteRole = Role::updateOrCreate(
            ['id' => 5, 'guard_name' => 'api'],
            ['level' => 5, 'guard_name' => 'api', 'slug' => 'institute']
        );
        $instituteRole->translations()->firstOrCreate(['locale' => 'en', 'name' => 'Institute']);
        $instituteRole->translations()->firstOrCreate(['locale' => 'ar', 'name' => 'معهد']);

        // Create or update permissions
        $editUsersPermission = Permission::updateOrCreate(
            ['id' => 3, 'guard_name' => 'api'],
            ['guard_name' => 'api']
        );
        $editUsersPermission->translations()->firstOrCreate(['locale' => 'en', 'name' => 'Edit Users']);
        $editUsersPermission->translations()->firstOrCreate(['locale' => 'ar', 'name' => 'تعديل المستخدمين']);

        $viewCoursesPermission = Permission::updateOrCreate(
            ['id' => 4, 'guard_name' => 'api'],
            ['guard_name' => 'api']
        );
        $viewCoursesPermission->translations()->firstOrCreate(['locale' => 'en', 'name' => 'View Courses']);
        $viewCoursesPermission->translations()->firstOrCreate(['locale' => 'ar', 'name' => 'عرض الدورات']);

        // Attach permissions to Admin role
        $adminRole->permissions()->sync([3, 4]);


        // database/seeders/RolePermissionSeeder.php


        $permission = Permission::create(['id' => 4, 'guard_name' => 'api']);
        $permission->setTranslation('name', 'en', 'View Courses');
        $permission->setTranslation('name', 'ar', 'عرض الدورات');
        $permission->save();

        $studentRole = Role::find(3); // Student
        $studentRole->givePermissionTo($permission);

        $adminRole = Role::find(1); // Admin
        $adminRole->givePermissionTo($permission);

        $userStudent = User::where('email', 'mohamedalzohery2002st@gmail.com')->first();
        $userStudent->syncRoles(['student']);

        $userAdmin = User::where('email', 'mohamedalzohery2002@gmail.com')->first();
        $userAdmin->syncRoles(['admin']);
    }
}