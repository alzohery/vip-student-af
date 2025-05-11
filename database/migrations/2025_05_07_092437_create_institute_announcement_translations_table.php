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
        Schema::create('institute_announcement_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('institute_announcement_id')->constrained('institute_announcements', 'id', 'inst_announce_trans_id_foreign')->onDelete('cascade');
            $table->string('locale', 10);
            $table->string('title', 255)->comment('عنوان الإعلان مترجم');
            $table->text('description')->nullable()->comment('وصف مختصر للإعلان مترجم');
            $table->text('content')->nullable()->comment('محتوى الإعلان مترجم');
            $table->string('image_url', 255)->nullable()->comment('رابط لصورة الإعلان مترجم إذا لزم');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');

            $table->foreign('locale', 'inst_announce_trans_locale_foreign')->references('code')->on('languages')->onDelete('cascade');
            $table->unique(['institute_announcement_id', 'locale'], 'inst_announce_trans_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('institute_announcement_translations');
    }
};
