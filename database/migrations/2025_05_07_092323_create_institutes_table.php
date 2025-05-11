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
        Schema::create('institutes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('city_id')->nullable()->constrained()->onDelete('set null');
            $table->boolean('approved')->default(false);
            $table->string('logo', 255)->nullable()->comment('رابط شعار المعهد');
            $table->string('location_url', 255)->nullable()->comment('رابط الموقع الجغرافي');
            $table->string('training_license', 100)->nullable()->comment('رخصة مزاولة نشاط تدريبي');
            $table->string('commercial_registry', 100)->nullable()->comment('سجل تجاري ساري');
            $table->string('operating_license', 100)->nullable()->comment('رخصة تشغيل المكان');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('institutes');
    }
};
