<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PasienController;
use App\Http\Controllers\JadwalDokterController;
use App\Http\Controllers\AuthenticationController;
use App\Http\Controllers\Masterdata\KotaController;
use App\Http\Controllers\Masterdata\DokterController;
use App\Http\Controllers\Masterdata\ProvinsiController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/
Route::get('test', [PasienController::class, 'buatJanjiTemu']);
Route::get('info-janji-temu/validate/{no_tiket}', [PasienController::class, 'cekJanjiTemu'])->name('validate.ticket');
Route::controller(AuthenticationController::class)->group(function(){
    Route::post('register', 'register');
    Route::post('login', 'login');
    Route::prefix('masterdata')->group(function(){
        Route::get('list-provinsi', [ProvinsiController::class, 'getList']);
        Route::get('list-kota', [KotaController::class, 'getList']);
    });
    Route::middleware('auth:sanctum')->group(function(){
        Route::get('/user-info', 'getUserInfo');
        Route::post('/logout', 'logout');
    });
});
Route::middleware('auth:sanctum')->group(function(){
    Route::prefix('masterdata')->group(function(){
        Route::get('list-pasien-keluarga', [PasienController::class, 'getList']);
        Route::get('list-dokter', [DokterController::class, 'getList']);
        Route::get('list-jadwal-dokter', [JadwalDokterController::class, 'getList']);
    });
    Route::post('profile/storeUpdate', [PasienController::class, 'storeUpdateProfileAnggotaKeluarga']);
    Route::post('buat-janji', [PasienController::class, 'buatJanjiTemu']);
    Route::get('list-janji-temu', [PasienController::class, 'getListJanjiTemu']);
});
