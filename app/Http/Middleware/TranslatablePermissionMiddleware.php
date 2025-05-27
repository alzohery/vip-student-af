<?php

// namespace App\Http\Middleware;

// use Closure;
// use Illuminate\Http\Request;
// use Symfony\Component\HttpFoundation\Response;

// class TranslatablePermissionMiddleware
// {
//     /**
//      * Handle an incoming request.
//      *
//      * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
//      */
//     public function handle(Request $request, Closure $next): Response
//     {
//         return $next($request);
//     }
// }







// app/Http/Middleware/TranslatablePermissionMiddleware.php
namespace App\Http\Middleware;

use Closure;
use Spatie\Permission\Exceptions\UnauthorizedException;
use App\Models\Permission;

class TranslatablePermissionMiddleware
{
    public function handle($request, Closure $next, ...$permissions)
    {
        $user = auth('sanctum')->user();
        $locale = app()->getLocale();

        if (!$user) {
            throw UnauthorizedException::notLoggedIn();
        }

        foreach ($permissions as $permissionName) {
            $permission = Permission::whereHas('translations', function ($query) use ($permissionName, $locale) {
                $query->where('name', $permissionName)->where('locale', $locale);
            })->first();

            if (!$permission && $locale !== 'en') {
                // جرب الـ fallback locale (en)
                $permission = Permission::whereHas('translations', function ($query) use ($permissionName) {
                    $query->where('name', $permissionName)->where('locale', 'en');
                })->first();
            }

            if ($permission && $user->hasPermissionTo($permission)) {
                return $next($request);
            }
        }

        throw UnauthorizedException::forPermissions($permissions);
    }
}
