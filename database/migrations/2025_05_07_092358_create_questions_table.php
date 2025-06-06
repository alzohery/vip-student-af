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
        Schema::create('questions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('exam_id')->constrained()->onDelete('cascade');
            $table->enum('question_type', ['multiple_choice', 'true_false', 'text'])->default('multiple_choice');
            $table->decimal('score', 5, 2)->nullable();
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->index('exam_id');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('questions');
    }
};
