<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Models\Role;

return new class extends Migration
{
    public function up(): void
    {
        // Add slug column as nullable
        Schema::table('roles', function (Blueprint $table) {
            $table->string('slug', 50)->nullable()->after('id')->comment('Unique identifier for the role');
        });

        // Update existing roles with slugs
        $adminRole = Role::find(1);
        if ($adminRole) {
            $adminRole->update(['slug' => 'admin']);
        }

        // Add unique constraint
        Schema::table('roles', function (Blueprint $table) {
            $table->unique('slug', 'roles_slug_unique');
        });

        // Make slug non-nullable and set default to null for future records
        Schema::table('roles', function (Blueprint $table) {
            $table->string('slug', 50)->nullable(false)->default(null)->change();
        });
    }

    public function down(): void
    {
        Schema::table('roles', function (Blueprint $table) {
            $table->dropUnique('roles_slug_unique');
            $table->dropColumn('slug');
        });
    }
};