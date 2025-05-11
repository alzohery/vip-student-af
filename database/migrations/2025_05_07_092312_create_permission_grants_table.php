<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('permission_grants', function (Blueprint $table) {
            $table->id();
            $table->foreignId('role_id')->constrained()->onDelete('cascade');
            $table->foreignId('permission_id')->constrained()->onDelete('cascade');
            $table->foreignId('granted_by_role_id')->constrained('roles')->onDelete('cascade');
            $table->timestamp('granted_at');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->index('role_id');
            $table->index('permission_id');
            $table->index('granted_by_role_id');
        });
        
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('permission_grants');
    }
};
