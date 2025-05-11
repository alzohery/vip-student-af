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
        Schema::create('ticket_message_translations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('ticket_message_id')->constrained()->onDelete('cascade');
            $table->string('locale', 10);
            $table->text('message')->comment('نص الرسالة مترجم');
            $table->timestamp('created_at')->useCurrent()->comment('تاريخ الإنشاء');
            $table->timestamp('updated_at')->useCurrent()->comment('تاريخ التحديث');
            
            $table->foreign('locale', 'ticket_msg_trans_locale_foreign')->references('code')->on('languages')->onDelete('cascade');
            $table->unique(['ticket_message_id', 'locale'], 'ticket_msg_trans_unique');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ticket_message_translations');
    }
};
