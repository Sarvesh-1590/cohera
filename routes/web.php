<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

use App\Http\Controllers\Auth\GoogleController;

// Google OAuth routes for admin
Route::get('admin/auth/google', [GoogleController::class, 'redirectToGoogle'])->name('admin.auth.google');
Route::get('admin/auth/google/callback', [GoogleController::class, 'handleGoogleCallback'])->name('admin.auth.google.callback');

// Also support /auth/google/callback for Google OAuth (to match Google redirect)
Route::get('auth/google/callback', [GoogleController::class, 'handleGoogleCallback']);
