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
        Schema::create('institute_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_id')->constrained()->onDelete('cascade');
            $table->string('locale', 10);
            $table->string('name', 255)->comment('اسم المعهد مترجم');
            $table->text('description')->nullable()->comment('وصف المعهد مترجم');
            $table->text('fixed_address')->comment('العنوان الثابت مترجم');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->foreign('locale', 'inst_trans_locale_foreign')->references('code')->on('languages')->onDelete('cascade');
            $table->unique(['institute_id', 'locale'], 'inst_trans_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('institute_translations');
    }
};
