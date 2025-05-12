<?php

namespace Tests\Feature;

use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class DatabaseConnectionTest extends TestCase
{
    public function test_database_connection_is_testing()
    {
        dump([
            'env' => app()->environment(),
            'db' => DB::connection()->getDatabaseName()
        ]);

        $this->assertEquals('testing', app()->environment());
        $this->assertEquals('vip_student_test', DB::connection()->getDatabaseName());
    }
}
