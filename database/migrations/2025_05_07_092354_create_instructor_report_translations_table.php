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
        Schema::create('instructor_report_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('instructor_report_id')->constrained()->onDelete('cascade');
            $table->string('locale', 10);
            $table->string('subject_name', 100)->nullable()->comment('اسم المادة مترجم');
            $table->text('performance_analysis')->nullable()->comment('تحليل الأداء مترجم');
            $table->text('teacher_notes')->nullable()->comment('ملاحظات المعلم مترجمة');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->foreign('locale', 'inst_report_trans_locale_foreign')->references('code')->on('languages')->onDelete('cascade');
            $table->unique(['instructor_report_id', 'locale'], 'inst_report_trans_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('instructor_report_translations');
    }
};
