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
        Schema::create('resep_obat', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('detail_kunjungan_id');
            $table->unsignedBigInteger('obat_id');
            $table->integer('jumlah');
            $table->text('keterangan');
            $table->timestamps();

            $table->foreign('detail_kunjungan_id')->references('id')->on('detail_kunjungan')->onDelete('cascade');
            $table->foreign('obat_id')->references('id')->on('masterdata_obat');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('resep_obat');
    }
};
