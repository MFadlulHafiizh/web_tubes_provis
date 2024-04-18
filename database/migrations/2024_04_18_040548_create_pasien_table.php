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
        Schema::create('pasien', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->string('nik');
            $table->string('name');
            $table->enum('jenkel', ['Laki-laki', 'Perempuan']);
            $table->date('tgl_lahir');
            $table->string('tempat_lahir');
            $table->string('no_telp');
            $table->text('foto')->nullable();
            $table->text('file_bpjs')->nullable();
            $table->text('status')->nullable();
            $table->boolean('is_default')->default(0);
            $table->timestamps();

            $table->foreign('user_id')->references('id')->on('users');
            $table->foreign('tempat_lahir')->references('uid_kota')->on('kota');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pasien');
    }
};
