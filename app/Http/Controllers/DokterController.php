<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\Keluhan;
use App\Models\ResepObat;
use Illuminate\Http\Request;
use App\Models\DetailKunjungan;
use App\Models\Masterdata\Obat;
use App\Models\Masterdata\Dokter;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use App\Models\RujukanPenunjangMedis;
use App\Models\Masterdata\PenunjangMedis;
use Illuminate\Support\Facades\Validator;

class DokterController extends Controller
{
    public function getList(Request $request){
        try{
            $data = Dokter::with(['bidang', 'jadwal' => function($q)use($request){$q->where('hari', $request->hari)->with('ruangan');}]);
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
    public function buatJadwalKunjungan(Request $request, $is_json=true){
        $rules =  [
            'keluhan_id' => 'required',
            'tanggal' => 'required',
            'jam' => 'required',
            // 'is_enable' => 'required',
        ];
        // dd($request->all());

        $validator = Validator::make($request->all(), $rules);

        if($validator->fails()){
            $fieldsWithErrorMessagesArray = $validator->messages()->get('*');
            $messages = [];
            $txtMess = "";
            foreach($fieldsWithErrorMessagesArray as $key => $mess){
                array_push($messages, $mess);
                if($key == count($fieldsWithErrorMessagesArray)-1){
                    $txtMess .= $mess[0];
                }else{
                    $txtMess .= $mess[0] . " <br>";
                }
            }
            if($is_json == 'false'){
                return redirect()->back()->with('error', $txtMess);
            }
            return $this->sendError('Validation Error.', $messages);
        }
        DB::beginTransaction();
        try{
            $detailKunjungan = new DetailKunjungan;
            $detailKunjungan->keluhan_id = $request->keluhan_id;
            $detailKunjungan->agenda = $request->agenda ?? "Kunjungan Rutin";
            $detailKunjungan->tanggal = $request->tanggal;
            $detailKunjungan->jam = $request->jam;
            $detailKunjungan->status = $request->status ?? "akan_datang";
            $detailKunjungan->is_enable = $request->is_enable ?? false;
            $detailKunjungan->save();
            DB::commit();
            if($is_json == 'false'){
                return redirect()->back()->with('success', 'Berhasil membuat jadwal kunjungan');
            }
            return $this->sendResponse([], 'Berhasil membuat jadwal temu');
        }catch(\Throwable $th){
            DB::rollback();
            if($is_json == false){
                return redirect()->back()->with('error', 'Gagal membuat jadwal kunjungan');
            }
            return $this->sendError($th->getMessage(), [], 500);
        }
    }
    public function daftarPasien(){
        $data = Keluhan::where('dokter_id', Auth::user()->detailDokter->id)->with('pasien')
        ->whereHas('kunjungan', function($q){
            $q->whereIn('status', ['menunggu_panggilan', 'masuk_ruangan']);
        })
        ->orderBy('tanggal', 'asc')
        ->orderBy('jam', 'asc')
        ->get();
        return view('dokter.daftar_pasien', compact('data'));
    }
    public function detailKeluhan($id_keluhan){
        $data = Keluhan::selectRaw("
            keluhan.id,
            keluhan.pasien_id,
            keluhan.detail_keluhan,
            keluhan.is_bpjs,
            keluhan.dokter_id,
            keluhan.nomor_tiket,
            keluhan.qr_code,

            (SELECT 
            id FROM detail_kunjungan
            WHERE keluhan.id = detail_kunjungan.keluhan_id
            AND is_enable = true
            LIMIT 1
            ) as id_kunjungan,
            (SELECT 
            tanggal FROM detail_kunjungan
            WHERE keluhan.id = detail_kunjungan.keluhan_id
            AND is_enable = true
            LIMIT 1
            ) as tanggal,
            (SELECT 
            diagnosa FROM detail_kunjungan
            WHERE keluhan.id = detail_kunjungan.keluhan_id
            AND is_enable = true
            LIMIT 1
            ) as diagnosa,
            (SELECT 
            jam FROM detail_kunjungan
            WHERE keluhan.id = detail_kunjungan.keluhan_id
            AND is_enable = true
            LIMIT 1
            ) as jam,
            (SELECT 
            status FROM detail_kunjungan
            WHERE keluhan.id = detail_kunjungan.keluhan_id
            AND is_enable = true
            LIMIT 1
            ) as status
        ")
        ->with('pasien','kunjungan')->find($id_keluhan);
        
        $resepObat = ResepObat::where('detail_kunjungan_id', $data->id_kunjungan)->with('masterObat')->get();
        $rujukanPenunjang = RujukanPenunjangMedis::where('detail_kunjungan_id', $data->id_kunjungan)->with('masterPenunjangMedis')->get();
        $obat = Obat::get();
        $penunjangMedis = PenunjangMedis::get();
        // return $data;
        return view('dokter.input_diagnosa', compact('data', 'obat', 'resepObat', 'penunjangMedis', 'rujukanPenunjang'));
    }

    public function createDiagnosa(Request $request){
        $rules =  [
            'diagnosa' => 'required',
            'id_kunjungan' => 'required',
        ];

        $validator = Validator::make($request->all(), $rules);

        if($validator->fails()){
            $fieldsWithErrorMessagesArray = $validator->messages()->get('*');
            $messages = [];
            foreach($fieldsWithErrorMessagesArray as $mess){
                array_push($messages, $mess);
            }
            return $this->sendError('Validation Error.', $messages);
        }
        DB::beginTransaction();
        try{
            $data = DetailKunjungan::where('id', $request->id_kunjungan)->update(['diagnosa' => $request->diagnosa]);
            
            DB::commit();
            return redirect()->back()->with('success', 'Diagnosa berhasil disimpan');
        }catch(\Throwable $th){
            DB::rollback();
            return redirect()->back()->with('success', 'Diagnosa gagal disimpan');
            return $this->sendError($th->getMessage(), [], 500);
        }
    }

    public function createResepObat(Request $request){
        $data = new ResepObat;
        if($request->resep_obat_id){
            $data = ResepObat::find($request->resep_obat_id);
        }
        $data->detail_kunjungan_id = $request->detail_kunjungan_id;
        $data->obat_id = $request->obat_id;
        $data->jumlah = $request->jumlah;
        $data->keterangan = $request->keterangan;
        $data->save();

        return redirect()->back()->with('success', 'Data berhasil disimpan');
    }

    public function deleteResepObat(Request $request){
        $data = ResepObat::findOrfail($request->resep_id);
        if($data->delete()){
            return redirect()->back()->with('success', "Resep obat berhasil dihapus");
        }
        return redirect()->back()->with('error', 'Resep obat gagal dihapus');
    }
    public function createPenunjangMedis(Request $request){
        $data = new RujukanPenunjangMedis;
        $data->detail_kunjungan_id = $request->detail_kunjungan_id;
        $data->penunjang_id = $request->penunjang_id;
        $data->save();

        return redirect()->back()->with('success', 'Data berhasil disimpan');
    }

    public function deletePenunjangMedis(Request $request){
        $data = RujukanPenunjangMedis::findOrfail($request->penunjang_id);
        if($data->delete()){
            return redirect()->back()->with('success', "Resep obat berhasil dihapus");
        }
        return redirect()->back()->with('error', 'Resep obat gagal dihapus');
    }

    public function uploadPenunjangMedis(Request $request){
        DB::beginTransaction();
        try{
            if($request->hasFile('lampiran')){
                foreach ($request->file('lampiran') as $key => $file) {
                    $originalName = $file->getClientOriginalName();
                    $filename = $request->rujukan_id[$key] . '_' .date('dmYhis') . $originalName;
                    $file->storeAs('detail_kunjungan/lamp_penunjang/', $filename, "public");
                    $lampiran = 'detail_kunjungan/lamp_penunjang/'.$filename;
                    RujukanPenunjangMedis::where('id', $request->rujukan_id[$key])->update(['hasil_penunjang' => $lampiran]);
                }
            }
            DB::commit();
            return $this->sendResponse([], 'Berhasil upload penunjang medis');
        }catch(\Throwable $th){
            DB::rollback();
            return $this->sendError($th->getMessage(), [], 500);
        }
    }
}
