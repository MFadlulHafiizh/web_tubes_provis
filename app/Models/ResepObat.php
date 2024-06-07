<?php

namespace App\Models;

use App\Models\Masterdata\Obat;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ResepObat extends Model
{
    use HasFactory;
    protected $table = 'resep_obat';
    protected $guarded = ['id'];

    public function masterObat(){
        return $this->belongsTo(Obat::class, 'obat_id');
    }
}
