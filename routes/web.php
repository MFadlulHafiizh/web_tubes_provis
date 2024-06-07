<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DokterController;
use App\Http\Controllers\PasienController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', [PasienController::class, 'indexValidasiKehadiran']);
Route::get('pasien/validasi-kehadiran', [PasienController::class, 'indexValidasiKehadiran']);
Route::post('change-status', [PasienController::class, 'changeStatus']);

Route::middleware(['auth'])->group(function () {
    Route::prefix('dokter')->group(function(){
        Route::get('pekerjaan/daftar-pasien', [DokterController::class, 'daftarPasien'])->name('dokter.daftar-pasien');
        Route::get('input-diagnosa/{id_keluhan}', [DokterController::class, 'detailKeluhan'])->name('dokter.input-diagnosa');
        Route::post('set-diagnosa', [DokterController::class, 'createDiagnosa'])->name('dokter.diagnosa.storeUpdate');
        Route::post('resep-obat/store', [DokterController::class, 'createResepObat'])->name('dokter.resep-obat.store');
        Route::delete('resep-obat/delete', [DokterController::class, 'deleteResepObat'])->name('dokter.resep-obat.delete');
        Route::post('penunjang-medis/store', [DokterController::class, 'createPenunjangMedis'])->name('dokter.penunjang-medis.store');
        Route::delete('penunjang-medis/delete', [DokterController::class, 'deletePenunjangMedis'])->name('dokter.penunjang-medis.delete');
        Route::post('rawat-jalan/storeUpdate/{is_json}', [DokterController::class, 'buatJadwalKunjungan'])->name('dokter.rawat-jalan.storeupdate');
    });
});

Auth::routes();
