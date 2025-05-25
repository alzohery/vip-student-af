<?php

namespace Database\Seeders;

use App\Models\Role;
use Illuminate\Database\Seeder;

class RoleSeeder extends Seeder
{
    public function run()
    {

        // Create or update Admin role
        $adminRole = Role::updateOrCreate(
            ['id' => 1, 'guard_name' => 'web'],
            ['level' => 1, 'guard_name' => 'web', 'slug' => 'admin']
        );
        $adminRole->translations()->firstOrCreate(['locale' => 'en', 'name' => 'Admin']);
        $adminRole->translations()->firstOrCreate(['locale' => 'ar', 'name' => 'مدير']);

        // Create or update Guardian role
        $guardianRole = Role::updateOrCreate(
            ['id' => 2, 'guard_name' => 'web'],
            ['level' => 2, 'guard_name' => 'web', 'slug' => 'guardian']
        );
        $guardianRole->translations()->firstOrCreate(['locale' => 'en', 'name' => 'Guardian']);
        $guardianRole->translations()->firstOrCreate(['locale' => 'ar', 'name' => 'ولي الأمر']);

        // Create or update Student role
        $studentRole = Role::updateOrCreate(
            ['id' => 3, 'guard_name' => 'web'],
            ['level' => 3, 'guard_name' => 'web', 'slug' => 'student']
        );
        $studentRole->translations()->firstOrCreate(['locale' => 'en', 'name' => 'Student']);
        $studentRole->translations()->firstOrCreate(['locale' => 'ar', 'name' => 'طالب']);

        // Create or update Teacher role
        $teacherRole = Role::updateOrCreate(
            ['id' => 4, 'guard_name' => 'web'],
            ['level' => 4, 'guard_name' => 'web', 'slug' => 'teacher']
        );
        $teacherRole->translations()->firstOrCreate(['locale' => 'en', 'name' => 'Teacher']);
        $teacherRole->translations()->firstOrCreate(['locale' => 'ar', 'name' => 'معلم']);

        // Create or update Institute role
        $instituteRole = Role::updateOrCreate(
            ['id' => 5, 'guard_name' => 'web'],
            ['level' => 5, 'guard_name' => 'web', 'slug' => 'institute']
        );
        $instituteRole->translations()->firstOrCreate(['locale' => 'en', 'name' => 'Institute']);
        $instituteRole->translations()->firstOrCreate(['locale' => 'ar', 'name' => 'معهد']);
    }
}