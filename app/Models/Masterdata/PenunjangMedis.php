<?php

namespace App\Models\Masterdata;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PenunjangMedis extends Model
{
    use HasFactory;
    protected $table = 'masterdata_penunjang_medis';
    protected $guarded = ['id'];
}
