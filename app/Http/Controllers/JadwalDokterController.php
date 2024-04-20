<?php

namespace App\Http\Controllers;

use App\Models\JadwalDokter;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class JadwalDokterController extends Controller
{
    public function getList(Request $request){
        try{
            $validator = Validator::make($request->all(), ["hari" => "required|in:Senin,Selasa,Rabu,Kamis,Jumat,Sabtu,Minggu"]);

            if($validator->fails()){
                $fieldsWithErrorMessagesArray = $validator->messages()->get('*');
                $messages = [];
                foreach($fieldsWithErrorMessagesArray as $mess){
                    array_push($messages, $mess);
                }
                return $this->sendError('Validation Error.', $messages);
            }
            $data = JadwalDokter::selectRaw("hari, MIN(jam_mulai), MAX(jam_berakhir)")
            ->where('hari', $request->hari)
            ->groupBy('hari')
            ->first();
            $detachTime = ["min" => explode(":", $data->min), "max" => explode(":", $data->max)];
            
            $dropdownTime = [];
            $index = 0;
            for ($i=(int)$detachTime["min"][0]; $i <= (int)$detachTime["max"][0]; $i++) { 
                $jam = $i;
                $menit = 45;
                if($jam == (int)$detachTime["max"][0]){
                    $menit = (int)$detachTime["max"][1];
                    if($menit != 0){
                        array_push($dropdownTime, ["jam" => $jam, "menit" => []]);
                        for($j=0; $j<$menit; $j+=15){
                            array_push($dropdownTime[$index]['menit'], $j);
                        }
                        $index++;
                    } 
                }else{
                    if($menit != 0){
                        array_push($dropdownTime, ["jam" => $jam, "menit" => []]);
                        for($j=0; $j<=$menit; $j+=15){
                            array_push($dropdownTime[$index]['menit'], $j);
                        }
                        $index++;
                    }
                }
                
            }
            $data->dropdownData = $dropdownTime;
            return $this->sendResponse($data, "Data berhasil diambil");
        }catch(\Throwable $e){
            return $this->sendError($e->getMessage(), [], 500);
        }
    }
}
