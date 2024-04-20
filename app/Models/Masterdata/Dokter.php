<?php

namespace App\Models\Masterdata;

use App\Models\JadwalDokter;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Dokter extends Model
{
    use HasFactory;
    
    protected $table = 'dokter';
    protected $guarded = ['id'];

    public function bidang(){
        return $this->belongsTo(BidangDokter::class, 'bidang_id');
    }
    public function jadwal(){
        return $this->hasMany(JadwalDokter::class, 'dokter_id');
    }
}
