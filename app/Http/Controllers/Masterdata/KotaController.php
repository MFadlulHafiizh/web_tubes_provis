<?php

namespace App\Http\Controllers\Masterdata;

use Illuminate\Http\Request;
use App\Models\Masterdata\Kota;
use App\Http\Controllers\Controller;

class KotaController extends Controller
{
    public function getList(Request $request){
        try{
            $data = Kota::query();
            if($request->uid_provinsi)
                $data->where('provinsi_uid', $request->uid_provinsi);
            $data = $data->get();
            return $this->sendResponse($data, "Data berhasil diambil");
        }catch(\Exception $e){
            return $this->sendError($e->getMessage(), [], 500);
        }
    }
}
