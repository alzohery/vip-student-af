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
        Schema::create('sub_category_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('sub_category_id')->constrained()->onDelete('cascade');
            $table->string('locale', 10);
            $table->string('name', 100)->comment('اسم التصنيف الفرعي مترجم');
            $table->text('description')->nullable()->comment('وصف التصنيف الفرعي مترجم');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->foreign('locale', 'sub_category_trans_locale_foreign')->references('code')->on('languages')->onDelete('cascade');
            $table->unique(['sub_category_id', 'locale'], 'sub_category_trans_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sub_category_translations');
    }
};
