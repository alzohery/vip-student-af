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
        Schema::create('audit_logs', function (Blueprint $table) {
            $table->id();
            $table->string('table_name', 100)->comment('اسم الجدول الذي تم تعديله');
            $table->unsignedBigInteger('record_id')->comment('معرف السجل الذي تم تعديله');
            $table->foreignId('changed_by')->constrained('users')->onDelete('cascade')->comment('المستخدم الذي قام بالتعديل');
            $table->timestamp('changed_at')->comment('وقت التعديل');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->index('changed_by');
            $table->index(['table_name', 'record_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('audit_logs');
    }
};
