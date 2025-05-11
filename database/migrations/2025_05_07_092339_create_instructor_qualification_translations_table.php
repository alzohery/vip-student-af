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
        Schema::create('instructor_qualification_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('instructor_qualification_id')->constrained('instructor_qualifications', 'id', 'inst_qual_trans_qual_id_foreign')->onDelete('cascade');
            $table->string('locale', 10);
            $table->string('qualification_name', 255)->comment('اسم المؤهل مترجم');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->foreign('locale', 'inst_qual_trans_locale_foreign')->references('code')->on('languages')->onDelete('cascade');
            $table->unique(['instructor_qualification_id', 'locale'], 'inst_qual_trans_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('instructor_qualification_translations');
    }
};
