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
        Schema::create('course_comments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('course_id')->constrained()->onDelete('cascade')->comment('معرف الدورة المرتبطة بالتعليق');
            $table->foreignId('user_id')->constrained()->onDelete('cascade')->comment('معرف المستخدم صاحب التعليق');
            $table->foreignId('rating_id')->nullable()->constrained('ratings', 'id', 'course_comments_rating_id_foreign')->onDelete('set null')->comment('معرف التقييم المرتبط بالتعليق');
            $table->foreignId('parent_comment_id')->nullable()->constrained('course_comments', 'id', 'course_comments_parent_id_foreign')->onDelete('set null')->comment('معرف التعليق الأب للردود');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
        });
    
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('course_comments');
    }
};
