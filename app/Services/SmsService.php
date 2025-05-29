<?php

namespace App\Services;

use Twilio\Rest\Client;

class SmsService
{
    protected $twilio;

    public function __construct()
    {
        $this->twilio = new Client(env('TWILIO_SID'), env('TWILIO_AUTH_TOKEN'));
    }

    public function sendVerificationCode($phoneNumber, $code)
    {
        $this->twilio->messages->create(
            $phoneNumber,
            [
                'from' => env('TWILIO_PHONE_NUMBER'),
                'body' => "Your verification code is: $code"
            ]
        );
    }

    public function verifyCode($phoneNumber, $code)
    {
        // هنا ممكن تضيف منطق التحقق (مثلاً تخزين الكود في Redis)
        return true; // للاختبار
    }
}