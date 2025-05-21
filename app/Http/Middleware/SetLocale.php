<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\App;
use App\Models\Language;

class SetLocale
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    // public function handle(Request $request, Closure $next): Response
    // {
    //     return $next($request);
    // }





    public function handle(Request $request, Closure $next)
    {
        $locale = $request->header('Accept-Language', 'en');

        if (Language::where('code', $locale)->exists()) {
            App::setLocale($locale);
        } else {
            App::setLocale('en'); // اللغة الافتراضية
        }

        return $next($request);
    }


}
