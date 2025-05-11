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
        // Schema::create('schedule_translations', function (Blueprint $table) {
        //     $table->id();
        //     $table->foreignId('schedule_id')->constrained()->onDelete('cascade');
        //     $table->string('locale', 10);
        //     $table->string('location', 255)->nullable()->comment('الموقع مترجم إذا لزم');
        //     $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
        //     $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
        //     $table->foreign('locale', 'schedule_trans_locale_foreign')->references('code')->on('languages')->onDelete('cascade');
        //     $table->unique(['schedule_id', 'locale'], 'schedule_trans_unique');
        // });

        Schema::create('schedule_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('schedule_id')->constrained()->onDelete('cascade');
            $table->string('locale', 10);
            $table->string('location', 255)->nullable()->comment('الموقع مترجم إذا لزم');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->foreign('locale', 'schedule_trans_locale_foreign')->references('code')->on('languages')->onDelete('cascade');
            $table->unique(['schedule_id', 'locale'], 'schedule_trans_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('schedule_translations');
    }
};
