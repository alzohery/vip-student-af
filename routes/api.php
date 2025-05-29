<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\CourseController;



Route::get('timezones', function () { return response()->json(timezone_identifiers_list()); });
Route::get('countries', function () { return \Rinvex\Country\CountryLoader::countries(); });

Route::prefix('auth')->group(function () {

    // مفيش محميح 😴😂
    Route::post('register', [AuthController::class, 'register']);
    Route::post('login', [AuthController::class, 'login']);
    Route::post('forgot-password', [AuthController::class, 'forgotPassword']);
    Route::post('reset-password', [AuthController::class, 'resetPassword']);

    // محميتين 😂
    Route::middleware('auth:sanctum')->group(function () {
        Route::post('logout', [AuthController::class, 'logout']);
        Route::put('profile', [AuthController::class, 'updateProfile']);
    });
});

// محميتين تاني لل users 😂
Route::middleware('auth:sanctum')->get('/user', function () {
    return response()->json(auth()->user());
});

// تاني محميتين 😂
// Route::middleware('auth:sanctum')->group(function () {
//     Route::get('courses', [CourseController::class, 'index']);
// });

// Route::middleware('auth:sanctum')->group(function () {
//     Route::get('courses', [CourseController::class, 'index']);
// });

// Route::middleware(['auth:sanctum', 'permission:View Courses'])->group(function () {
//     Route::get('courses', [CourseController::class, 'index']);
// });

// routes/api.php
Route::middleware(['auth:sanctum', 'permission.translatable:View Courses'])->group(function () {
    Route::get('courses', [CourseController::class, 'index']);
});

Route::post('/send-sms', [AuthController::class, 'sendVerificationCode']);
Route::post('/verify-sms', [AuthController::class, 'verifyCode']);
