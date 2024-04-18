<?php

namespace App\Http\Controllers\Masterdata;

use Illuminate\Http\Request;
use App\Models\Masterdata\Provinsi;
use App\Http\Controllers\Controller;

class ProvinsiController extends Controller
{
    public function getList(Request $request){
        try{
            $data = Provinsi::get();
            return $this->sendResponse($data, "Data berhasil diambil");
        }catch(\Exception $e){
            return $this->sendError($e->getMessage(), [], 500);
        }
    }
}
