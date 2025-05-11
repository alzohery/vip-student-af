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
        Schema::create('instructor_qualifications', function (Blueprint $table) {
            $table->id();
            $table->foreignId('instructor_profile_id')->constrained()->onDelete('cascade');
            $table->string('institution', 255)->nullable();
            $table->year('year_obtained')->nullable();
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->index('instructor_profile_id');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('instructor_qualifications');
    }
};
