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
        Schema::create('page_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('page_id')->constrained()->onDelete('cascade');
            $table->string('locale', 10);
            $table->string('title', 255)->comment('عنوان الصفحة مترجم');
            $table->string('slug', 255)->comment('Slug مترجم للروابط (مثل about, عنا)');
            $table->text('content')->nullable()->comment('محتوى الصفحة مترجم');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->foreign('locale', 'page_trans_locale_foreign')->references('code')->on('languages')->onDelete('cascade');
            $table->unique(['page_id', 'locale'], 'page_trans_unique');
            $table->index('slug');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('page_translations');
    }
};
