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
        Schema::create('rujukan_penunjang', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('detail_kunjungan_id');
            $table->unsignedBigInteger('penunjang_id');
            $table->timestamps();

            $table->foreign('detail_kunjungan_id')->references('id')->on('detail_kunjungan')->onDelete('cascade');
            $table->foreign('penunjang_id')->references('id')->on('masterdata_penunjang_medis');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rujukan_penunjang');
    }
};
