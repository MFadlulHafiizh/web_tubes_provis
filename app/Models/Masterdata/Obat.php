<?php

namespace App\Models\Masterdata;

use App\Models\ResepObat;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Obat extends Model
{
    use HasFactory;
    protected $table = 'masterdata_obat';
    protected $guarded = ['id'];

    public function resepObat(){
        return $this->hasMany(ResepObat::class, 'obat_id');
    }
}
