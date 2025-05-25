<?php

// use Illuminate\Http\Request;
// use Illuminate\Support\Facades\Route;

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');


use Illuminate\Support\Facades\Route;
// use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\Api\AuthController;

Route::prefix('auth')->group(function () {
    Route::post('register', [AuthController::class, 'register']);
    Route::post('login', [AuthController::class, 'login']);

    Route::post('forgot-password', [AuthController::class, 'forgotPassword']);
    Route::post('reset-password', [AuthController::class, 'resetPassword']);
    
    /** countries **/
    Route::get('/countries', function () {
        return \Rinvex\Country\CountryLoader::countries();
    });

    /** timezones **/
    Route::get('/timezones', function () {
        return response()->json(timezone_identifiers_list());
    });

    /** password reset **/
    // Route::get('password/reset/{token}', [YourResetController::class, 'showResetForm'])->name('password.reset');
    
    Route::middleware('auth:sanctum')->group(function () {
        Route::post('logout', [AuthController::class, 'logout']);
        Route::put('profile', [AuthController::class, 'updateProfile']); // مثال
    });
});
