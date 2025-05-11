<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    // 19. institute_certificate_translations
    public function up(): void
    {
        Schema::create('institute_certificate_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_certificate_id')->constrained('institute_certificates', 'id', 'inst_cert_trans_cert_id_foreign')->onDelete('cascade');
            $table->string('locale', 10);
            $table->string('certificate_name', 255)->comment('اسم الشهادة مترجم');
            $table->string('certificate_file', 255)->nullable()->comment('رابط أو مسار الملف مترجم إذا لزم');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->foreign('locale', 'inst_cert_trans_locale_foreign')->references('code')->on('languages')->onDelete('cascade');
            $table->unique(['institute_certificate_id', 'locale'], 'inst_cert_trans_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('institute_certificate_translations');
    }
};
