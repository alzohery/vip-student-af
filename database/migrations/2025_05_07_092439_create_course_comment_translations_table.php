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
        Schema::create('course_comment_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('course_comment_id')
                  ->constrained('course_comments', 'id', 'course_comment_trans_id_foreign')
                  ->onDelete('cascade');
            $table->string('locale', 10);
            $table->text('content')->comment('محتوى التعليق مترجم');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
    
            $table->foreign('locale', 'course_comment_trans_locale_foreign')
                  ->references('code')
                  ->on('languages')
                  ->onDelete('cascade');
            $table->unique(['course_comment_id', 'locale'], 'course_comment_trans_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('course_comment_translations');
    }
};
