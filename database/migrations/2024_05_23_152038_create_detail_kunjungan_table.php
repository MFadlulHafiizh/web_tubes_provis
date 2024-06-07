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
        Schema::create('detail_kunjungan', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('keluhan_id');
            $table->text('agenda');
            $table->date('tanggal');
            $table->time('jam');
            $table->string('status');
            $table->text('diagnosa')->nullable();
            $table->text('bukti_pembayaran')->nullable();
            $table->timestamp('tanggal_bayar')->nullable();
            $table->double('total_harga')->nullable();
            $table->boolean('is_enable');
            $table->timestamps();


            $table->foreign('keluhan_id')->references('id')->on('keluhan')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('detail_kunjungan');
    }
};
