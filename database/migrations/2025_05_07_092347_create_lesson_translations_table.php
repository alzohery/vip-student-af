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
        Schema::create('lesson_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('lesson_id')->constrained()->onDelete('cascade');
            $table->string('locale', 10);
            $table->string('title', 255)->comment('عنوان الدرس مترجم');
            $table->text('description')->nullable()->comment('وصف الدرس مترجم');
            $table->string('lesson_venue', 255)->nullable()->comment('مكان الدرس مترجم إذا لزم');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->foreign('locale', 'lesson_trans_locale_foreign')->references('code')->on('languages')->onDelete('cascade');
            $table->unique(['lesson_id', 'locale'], 'lesson_trans_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('lesson_translations');
    }
};
