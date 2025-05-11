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
        Schema::create('question_option_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('question_option_id')->constrained()->onDelete('cascade');
            $table->string('locale', 10);
            $table->text('option_text')->comment('نص الخيار مترجم');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->foreign('locale', 'question_opt_trans_locale_foreign')->references('code')->on('languages')->onDelete('cascade');
            $table->unique(['question_option_id', 'locale'], 'question_opt_trans_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('question_option_translations');
    }
};
