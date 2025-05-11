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
        Schema::create('institute_announcements', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained()->onDelete('cascade');
            $table->enum('target_audience', ['students', 'parents', 'all'])->default('all')->comment('الجمهور المستهدف من الإعلان');
            $table->integer('priority')->default(0)->comment('أولوية العرض (الأعلى أولاً)');
            $table->timestamp('published_at')->nullable()->comment('وقت نشر الإعلان');
            $table->timestamp('expiry_date')->nullable()->comment('تاريخ انتهاء صلاحية الإعلان');
            $table->boolean('is_active')->default(true)->comment('حالة الإعلان (نشط أو غير نشط)');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->index('institute_id');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('institute_announcements');
    }
};
