<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Spatie\Permission\PermissionRegistrar;

class AppServiceProvider extends ServiceProvider
{
public function register()
    {
        $this->app->singleton('permission', function ($app) {
            return new PermissionRegistrar($app['cache']);
        });
    }

    public function boot()
    {
        //
    }
}