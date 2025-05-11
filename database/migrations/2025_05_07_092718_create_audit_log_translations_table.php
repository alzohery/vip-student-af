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
        Schema::create('audit_log_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('audit_log_id')->constrained()->onDelete('cascade');
            $table->string('locale', 10);
            $table->string('action', 50)->comment('الإجراء مترجم');
            $table->text('old_value')->nullable()->comment('القيمة القديمة مترجمة');
            $table->text('new_value')->nullable()->comment('القيمة الجديدة مترجمة');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->foreign('locale')->references('code')->on('languages')->onDelete('cascade');
            $table->unique(['audit_log_id', 'locale']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('audit_log_translations');
    }
};
