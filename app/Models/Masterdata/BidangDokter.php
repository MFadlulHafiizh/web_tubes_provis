<?php

namespace App\Models\Masterdata;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BidangDokter extends Model
{
    use HasFactory;
    protected $table = 'bidang_dokter';
    protected $guarded = ['id'];
}
