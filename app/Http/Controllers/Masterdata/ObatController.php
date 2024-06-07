<?php

namespace App\Http\Controllers\Masterdata;

use Illuminate\Http\Request;
use App\Models\Masterdata\Obat;
use App\Http\Controllers\Controller;

class ObatController extends Controller
{
    public function getList(Request $request){
        try{
            $data = Obat::query();
            $data = $data->get();
            return $this->sendResponse($data, "Data berhasil diambil");
        }catch(\Throwable $e){
            return $this->sendError($e->getMessage(), [], 500);
        }
    }
}
