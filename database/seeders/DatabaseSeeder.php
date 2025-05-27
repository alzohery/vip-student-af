<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run()
    {
        $this->call([
            LanguageSeeder::class,
            CitySeeder::class,
            RolePermissionSeeder::class,
            UserSeeder::class,
        ]);
    }
}
//         $this->call([
//             LanguageSeeder::class,
//             CitySeeder::class,
//             RolePermissionSeeder::class,
//             RoleSeeder::class,
//             UserSeeder::class,
//         ]);
//     }
// }
