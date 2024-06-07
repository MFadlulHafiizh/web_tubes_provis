<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Masterdata\PenunjangMedis;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class RujukanPenunjangMedis extends Model
{
    use HasFactory;
    
    protected $table = 'rujukan_penunjang';
    protected $guarded = ['id'];

    public function masterPenunjangMedis(){
        return $this->belongsTo(PenunjangMedis::class, 'penunjang_id');
    }
}
