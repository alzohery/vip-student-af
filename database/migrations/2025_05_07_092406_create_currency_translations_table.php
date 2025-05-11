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
        Schema::create('currency_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('currency_id')->constrained()->onDelete('cascade');
            $table->string('locale', 10);
            $table->string('code', 10)->comment('رمز العملة (مثل USD, EGP)');
            $table->string('name', 100)->comment('اسم العملة مترجم');
            $table->string('symbol', 10)->nullable()->comment('رمز العملة مترجم');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->foreign('locale', 'currency_trans_locale_foreign')->references('code')->on('languages')->onDelete('cascade');
            $table->unique(['currency_id', 'locale'], 'currency_trans_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('currency_translations');
    }
};
