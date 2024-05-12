<?php

namespace App\Models;

use App\Models\Masterdata\Dokter;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Keluhan extends Model
{
    use HasFactory;
    protected $table = 'keluhan';
    protected $guarded = ['id'];

    public function pasien(){
        return $this->belongsTo(Pasien::class, 'pasien_id');
    }
    public function dokter(){
        return $this->belongsTo(Dokter::class, 'dokter_id');
    }
}
