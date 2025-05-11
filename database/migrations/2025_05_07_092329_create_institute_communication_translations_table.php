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
        Schema::create('institute_communication_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_communication_id')->constrained('institute_communications', 'id', 'inst_comm_trans_comm_id_foreign')->onDelete('cascade');
            $table->string('locale', 10);
            $table->string('value', 255)->comment('قيمة وسيلة التواصل مترجمة إذا لزم');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->foreign('locale', 'inst_comm_trans_locale_foreign')->references('code')->on('languages')->onDelete('cascade');
            $table->unique(['institute_communication_id', 'locale'], 'inst_comm_trans_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('institute_communication_translations');
    }
};
