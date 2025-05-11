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
        
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->foreignId('role_id')->constrained()->onDelete('cascade');
            $table->foreignId('institute_id')->nullable()->constrained()->onDelete('set null')->comment('في حال انتماء المستخدم لمعهد');
            $table->string('name', 100);
            $table->string('email', 255)->unique();
            $table->string('password', 255)->comment('يجب تشفير كلمة المرور');
            $table->string('profile_picture', 255)->nullable();
            $table->date('birthdate')->nullable();
            $table->foreignId('city_id')->nullable()->constrained()->onDelete('set null');
            $table->string('country', 100)->nullable();
            $table->string('zip_code', 20)->nullable();
            $table->string('phone', 20)->nullable();
            $table->string('timezone', 50)->nullable();
            $table->dateTime('last_login_at')->nullable();
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->index('role_id');
            $table->index('institute_id');
            $table->index('city_id');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};
