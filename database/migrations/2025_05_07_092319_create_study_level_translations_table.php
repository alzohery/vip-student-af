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
        Schema::create('study_level_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('study_level_id')->constrained()->onDelete('cascade');
            $table->string('locale', 10);
            $table->string('name', 100)->comment('اسم المستوى مترجم');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->foreign('locale', 'study_level_trans_locale_foreign')->references('code')->on('languages')->onDelete('cascade');
            $table->unique(['study_level_id', 'locale'], 'study_level_trans_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('study_level_translations');
    }
};
