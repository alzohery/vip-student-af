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
        

        Schema::create('ratings', function (Blueprint $table) {
            $table->id()->comment('معرف التقييم');
            $table->foreignId('course_id')->constrained()->onDelete('cascade')->comment('معرف الدورة المرتبطة بالتقييم');
            $table->foreignId('user_id')->constrained()->onDelete('cascade')->comment('معرف المستخدم صاحب التقييم');
            $table->unsignedTinyInteger('rating')->comment('قيمة التقييم (1-5)');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');

            $table->unique(['user_id', 'course_id'], 'ratings_user_course_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ratings');
    }
};
