<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Role;

class UserSeeder extends Seeder
{
    public function run()
    {
        $adminRole = Role::whereHas('translations', function ($query) {
            $query->where('name', 'Admin')->where('locale', 'en');
        })->first();

        if (!$adminRole) {
            $this->command->warn('Admin role not found. Skipping user creation.');
            return;
        }

        User::create([
            'name' => 'Admin User',
            'email' => 'admin@vipstudent.com',
            'password' => bcrypt('password'),
            'role_id' => $adminRole->id,
        ]);
    }
}
