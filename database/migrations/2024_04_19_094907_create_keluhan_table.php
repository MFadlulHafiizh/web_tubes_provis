<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('keluhan', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('pasien_id');
            $table->text('detail_keluhan');
            $table->boolean('is_bpjs');
            $table->unsignedBigInteger('dokter_id');
            $table->date('tanggal');
            $table->time('jam');
            $table->string('nomor_tiket');
            $table->string('status');
            $table->text('qr_code');
            $table->timestamps();

            $table->foreign('pasien_id')->references('id')->on('pasien');
            $table->foreign('dokter_id')->references('id')->on('dokter');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('keluhan');
    }
};
