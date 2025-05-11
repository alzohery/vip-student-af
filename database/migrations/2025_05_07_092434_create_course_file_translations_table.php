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
        Schema::create('course_file_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('course_file_id')->constrained()->onDelete('cascade');
            $table->string('locale', 10);
            $table->string('file_name', 255)->comment('اسم الملف مترجم');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->foreign('locale', 'course_file_trans_locale_foreign')->references('code')->on('languages')->onDelete('cascade');
            $table->unique(['course_file_id', 'locale'], 'course_file_trans_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('course_file_translations');
    }
};
