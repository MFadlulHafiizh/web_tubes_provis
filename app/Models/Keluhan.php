<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Keluhan extends Model
{
    use HasFactory;
    protected $table = 'keluhan';
    protected $guarded = ['id'];

    public function jadwalDokter(){
        return $this->belongsTo(JadwalDokter::class, 'jadwal_dokter_id');
    }

    public function pasien(){
        return $this->belongsTo(Pasien::class, 'pasien_id');
    }
}
