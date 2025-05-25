<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

use Illuminate\Support\Facades\Lang;

class ResetPassword extends Notification
{
    use Queueable;

    public $token;
    /**
     * Create a new notification instance.
     */
    public function __construct($token)
    {
        $this->token = $token;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['mail'];
    }

    /**
     * Get the mail representation of the notification.
     */
    // public function toMail(object $notifiable): MailMessage
    // {
    //     $url = url('/reset-password?token=' . $this->token . '&email=' . urlencode($notifiable->getEmailForPasswordReset()));
    //     return (new MailMessage)
    //         ->subject(Lang::get('auth.password_reset_subject'))
    //         ->line(Lang::get('auth.password_reset_line1'))
    //         ->action(Lang::get('auth.password_reset_action'), $url)
    //         ->line(Lang::get('auth.password_reset_line2', ['count' => config('auth.passwords.users.expire')]))
    //         ->line(Lang::get('auth.password_reset_line3'));
    // }

    public function toMail($notifiable)
    {
        $url = url('/reset-password?token=' . $this->token . '&email=' . urlencode($notifiable->getEmailForPasswordReset()));

        return (new MailMessage)
            ->subject(Lang::get('auth.password_reset_subject'))
            ->line(Lang::get('auth.password_reset_line1'))
            ->action(Lang::get('auth.password_reset_action'), $url)
            ->line(Lang::get('auth.password_reset_line2', ['count' => config('auth.passwords.users.expire')]))
            ->line(Lang::get('auth.password_reset_line3'));
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        return [
            //
        ];
    }
}
