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
        Schema::create('admin_log_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('admin_log_id')->constrained()->onDelete('cascade');
            $table->string('locale', 10);
            $table->text('action')->comment('الإجراء مترجم');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->foreign('locale', 'admin_log_trans_locale_foreign')->references('code')->on('languages')->onDelete('cascade');
            $table->unique(['admin_log_id', 'locale'], 'admin_log_trans_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('admin_log_translations');
    }
};
