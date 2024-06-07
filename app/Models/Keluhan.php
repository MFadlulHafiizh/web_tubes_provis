<?php

namespace App\Models;

use Carbon\Carbon;
use App\Models\Masterdata\Dokter;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Keluhan extends Model
{
    use HasFactory;
    protected $table = 'keluhan';
    protected $guarded = ['id'];
    protected $appends = ['hari'];

    public function pasien(){
        return $this->belongsTo(Pasien::class, 'pasien_id');
    }
    public function dokter(){
        return $this->belongsTo(Dokter::class, 'dokter_id');
    }
    public function kunjungan(){
        return $this->hasMany(DetailKunjungan::class, 'keluhan_id')->orderBy('id', 'desc');
    }
    public function getStatusAttribute($value)
    {
        $result = $this->attributes['status'];
        $date = Carbon::parse($this->attributes['tanggal'])->toDateString();
        if($this->attributes['status'] == 'akan_datang' && $date == Carbon::now()->toDateString()){
            $result = 'sudah_waktunya';
        }else if($this->attributes['status'] == 'akan_datang' && $date < Carbon::now()->toDateString()){
            $result = 'kadaluarsa';
        }

        return $result;
    }

    public function getHariAttribute(){
        return Carbon::parse($this->attributes['tanggal'])->translatedFormat('l');
    }
}
