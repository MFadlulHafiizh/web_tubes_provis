<?php

namespace App\Models;

use App\Models\Masterdata\Dokter;
use App\Models\Masterdata\Ruangan;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class JadwalDokter extends Model
{
    use HasFactory;
    protected $table = 'jadwal_dokter';
    protected $guarded = ['id'];

    public function dokter(){
        return $this->belongsTo(Dokter::class, 'dokter_id');
    }
    public function ruangan(){
        return $this->belongsTo(Ruangan::class, 'ruang_id');
    }
}
