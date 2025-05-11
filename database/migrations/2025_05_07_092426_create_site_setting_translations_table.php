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
        Schema::create('site_setting_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('site_setting_id')->constrained()->onDelete('cascade');
            $table->string('locale', 10);
            $table->string('key', 255)->comment('مفتاح الإعداد مترجم');
            $table->text('value')->nullable()->comment('قيمة الإعداد مترجمة إذا لزم');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->foreign('locale', 'site_setting_trans_locale_foreign')->references('code')->on('languages')->onDelete('cascade');
            $table->unique(['site_setting_id', 'locale'], 'site_setting_trans_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('site_setting_translations');
    }
};
