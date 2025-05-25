<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('roles', function (Blueprint $table) {
            // Modify slug column to remove default(null), keep nullable(false) and existing unique index
            $table->string('slug')->nullable(false)->change();
        });
    }

    public function down(): void
    {
        Schema::table('roles', function (Blueprint $table) {
            // Revert to original definition if needed
            $table->string('slug')->nullable(false)->default(null)->change();
        });
    }
};