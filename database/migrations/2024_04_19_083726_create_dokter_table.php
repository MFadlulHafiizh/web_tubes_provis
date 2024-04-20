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
        Schema::create('dokter', function (Blueprint $table) {
            $table->id();
            $table->text('foto')->nullable();
            $table->text('nama_dokter');
            $table->text('jenkel');
            $table->date('tgl_lahir');
            $table->unsignedBigInteger('bidang_id');
            $table->timestamps();

            $table->foreign('bidang_id')->references('id')->on('bidang_dokter')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('dokter');
    }
};
