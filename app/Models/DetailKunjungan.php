<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class DetailKunjungan extends Model
{
    use HasFactory;
    protected $table = 'detail_kunjungan';
    protected $guarded = ['id'];

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
}
