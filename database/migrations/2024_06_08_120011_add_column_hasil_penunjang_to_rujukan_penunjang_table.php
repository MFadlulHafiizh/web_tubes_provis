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
        Schema::table('rujukan_penunjang', function (Blueprint $table) {
            $table->text('hasil_penunjang')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('rujukan_penunjang', function (Blueprint $table) {
            $table->dropColumn('hasil_penunjang');
        });
    }
};
