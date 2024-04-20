<?php

namespace App\Http\Controllers\Masterdata;

use Illuminate\Http\Request;
use App\Models\Masterdata\Dokter;
use App\Http\Controllers\Controller;

class DokterController extends Controller
{
    public function getList(Request $request){
        try{
            $data = Dokter::with(['bidang', 'jadwal' => function($q)use($request){$q->where('hari', $request->hari);}]);
            if($request->hari){
                $data->whereHas('jadwal', function($q)use($request){
                    $q->where('hari', $request->hari);
                    if($request->jam){
                        $q->whereTime('jam_berakhir', '>=', $request->jam);
                    }
                });
            }
            $data = $data->get();
            return $this->sendResponse($data, "Data berhasil diambil");
        }catch(\Throwable $e){
            return $this->sendError($e->getMessage(), [], 500);
        }
    }
}
