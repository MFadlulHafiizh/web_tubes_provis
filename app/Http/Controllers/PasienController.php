<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\User;
use App\Models\Pasien;
use App\Models\Keluhan;
use App\Models\ResepObat;
use App\Models\JadwalDokter;
use Illuminate\Http\Request;
use App\Models\DetailKunjungan;
use App\Models\Masterdata\Obat;

use App\Models\Masterdata\Dokter;
use Illuminate\Support\Facades\DB;
use App\Models\RujukanPenunjangMedis;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\DokterController;
use SimpleSoftwareIO\QrCode\Facades\QrCode;

class PasienController extends Controller
{
    public function getList(Request $request){
        try{
            $data = Pasien::where('user_id', $request->user()->id);
            if($request->is_keluarga == "true")
                $data->where('is_default', false);
            
            $data = $data->get();
            return $this->sendResponse($data, "Data berhasil diambil");
        }catch(\Throwable $e){
            return $this->sendError($e->getMessage(), [], 500);
        }
    }

    public function storeUpdateProfileAnggotaKeluarga(Request $request){
        $rules =  [
            'name' => 'required',
            // 'email' => 'email|unique:users,email',
            'nik' => 'required|integer',
            'jenkel' => 'required|in:Laki-laki,Perempuan',
            'tgl_lahir' => 'required|date',
            'tempat_lahir' => 'required|exists:kota,uid_kota',
            'no_telp' => 'required',
        ];
        $mode = "menambah";
        if($request->profile_id){
            $mode = "memperbaharui";
            $rules = [];
        }

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
            $newKeluarga = new Pasien;
            if($request->profile_id){
                $newKeluarga = Pasien::find($request->profile_id);
                if($newKeluarga->is_default == true){
                    $account = User::find($newKeluarga->user_id);
                    $account->name = $request->name;
                    if($request->email){
                        $account->email = $request->email;
                    }
                    if($request->password){
                        $account->password = bcrypt($request->password);
                        $account->salt = $request->password;
                    }
                    $account->save();
                }else{
                    $newKeluarga->is_default = false;
                }
            }else{
                $newKeluarga->is_default = false;
            }
            $newKeluarga->user_id = $request->user()->id;
            $newKeluarga->nik = $request->nik ?? $newKeluarga->nik;
            $newKeluarga->name = $request->name ?? $newKeluarga->name;
            $newKeluarga->jenkel = $request->jenkel ?? $newKeluarga->jenkel;
            $newKeluarga->tgl_lahir = $request->tgl_lahir ?? $newKeluarga->tgl_lahir;
            $newKeluarga->tempat_lahir = $request->tempat_lahir ?? $newKeluarga->tempat_lahir;
            $newKeluarga->no_telp = $request->no_telp ?? $newKeluarga->no_telp;
            
            if($request->hasFile('foto')){
                $file = $request->file('foto');
                $originalName = $file->getClientOriginalName();
                $filename = $request->user()->id . '_' .date('dmYhis') . $originalName;
                $file->storeAs('account/user_image/', $filename, "public");
                $newKeluarga->foto = 'account/user_image/'.$filename;
            }
            if($request->hasFile('file_bpjs')){
                $file = $request->file('file_bpjs');
                $originalName = $file->getClientOriginalName();
                $filename = $request->user()->id . '_' .date('dmYhis') . $originalName;
                $file->storeAs('account/bpjs/', $filename, "public");
                $newKeluarga->file_bpjs = 'account/bpjs/'.$filename;
            }
            $newKeluarga->save();
            DB::commit();
            return $this->sendResponse($newKeluarga, 'Berhasil '. $mode .' profile');
        }catch(\Throwable $th){
            DB::rollback();
            return $this->sendError($th->getMessage(), [], 500);
        }
    }

    public function deleteProfileAnggotaKeluarga(Request $request){
        try{
            $data = Pasien::find($request->pasien_id);
            if($data->delete()){
                return $this->sendResponse([], "Data berhasil dihapus");
            }
            return $this->sendError("Data gagal dihapus", []);
        }catch(\Exception $e){
            return $this->sendError($e->getMessage(), [], 500);
        }
    }

    public function buatJanjiTemu(Request $request){
        $rules =  [
            'pasien_id' => 'required',
            'detail_keluhan' => 'required',
            'is_bpjs' => 'required',
            'dokter_id' => 'required',
            'tanggal' => 'required',
            'jam' => 'required',
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
            $janjiTemu = new Keluhan;
            $janjiTemu->pasien_id = $request->pasien_id;
            $janjiTemu->detail_keluhan = $request->detail_keluhan;
            $janjiTemu->is_bpjs = $request->is_bpjs;
            $janjiTemu->dokter_id = $request->dokter_id;
            $janjiTemu->tanggal = $request->tanggal;
            $janjiTemu->jam = $request->jam;
            $ticketCode = 'TK'. Carbon::now()->format('dmys') . $request->pasien_id . $request->jadwal_dokter_id;
            $janjiTemu->nomor_tiket =  $ticketCode;
            $image = QrCode::size(300)
                ->generate($ticketCode);
            $url_image = 'tiket_pasien/'. $ticketCode . '.svg';
            Storage::disk('public')->put($url_image, $image);
            $janjiTemu->qr_code = $url_image;
            $janjiTemu->status = 'akan_datang';
            $janjiTemu->save();
            $bypass = new DokterController;
            
            $request['keluhan_id'] = $janjiTemu->id;
            $request['is_enable'] = true;
            $result = $bypass->buatJadwalKunjungan($request, false);
            if($result){
                DB::commit();
                $ticket = Keluhan::where('id', $janjiTemu->id)->with(['pasien','dokter.bidang'])->first();
                return $this->sendResponse($ticket, 'Berhasil membuat janji temu');
            }else{
                DB::rollback();
                return $this->sendError('Gagal membuat janji temu', [], 500);
            }
        }catch(\Throwable $th){
            DB::rollback();
            return $this->sendError($th->getMessage(), [], 500);
        }
    }

     public function getListJanjiTemu(Request $request){
        try{
            $allPasienFromUser = Pasien::where('user_id', $request->user()->id)->pluck('id');
            $janjiTemu = Keluhan::
            selectRaw("
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
            ->join('detail_kunjungan', 'detail_kunjungan.keluhan_id', 'keluhan.id')
            ->whereIn('pasien_id', $allPasienFromUser->toArray())
            ->with(['pasien', 'dokter.bidang'])
            ->groupBy('keluhan.id');
            $janjiTemu = $janjiTemu->get();
            if($request->is_riwayat == 'true'){
                $janjiTemu =  $janjiTemu->whereIn('status', ['selesai', 'kadaluarsa']);
            }else{
                $janjiTemu = $janjiTemu->whereNotIn('status', ['selesai', 'kadaluarsa']);
            }

            foreach ($janjiTemu as $key => $value) {
                $value->jadwal = JadwalDokter::where('dokter_id', $value->dokter_id)
                ->where('hari', $value->hari)
                ->whereTime('jam_berakhir', ">=", $value->jam)->with('ruangan')->first();
            }
            $janjiTemu = array_values($janjiTemu->toArray());
            return $this->sendResponse($janjiTemu, 'Data berhasil diambil');
        }
        catch(\Throwable $th){
            DB::rollback();
            return $this->sendError($th->getMessage(), [$th->getTrace()], 500);
        }
    }

    public function getListDetailKunjungan($id_keluhan){
        try{
            $data = DetailKunjungan::
            where('keluhan_id', $id_keluhan)
            ->with(['resepObat.masterObat', 'rujukanPenunjangMedis.masterPenunjangMedis', 'keluhan' => function ($q){
                $q->join('dokter', 'dokter.id', 'keluhan.dokter_id')
                ->join('bidang_dokter', 'bidang_dokter.id', 'dokter.bidang_id')
                ->select('keluhan.id','keluhan.tanggal', 'keluhan.dokter_id','bidang_dokter.tarif_konsultasi');
            }])->orderBy('tanggal','desc')
            ->get();
            return $this->sendResponse($data, 'Data berhasil diambil');
        }catch(\Throwable $th){
            return $this->sendError($th->getMessage(), [], 500);
        }
    }

    public function indexValidasiKehadiran(Request $request){
        return view('validasi_page');
    }

    public function cekJanjiTemu($no_tiket){
        try{
            $ticket = Keluhan::
            selectRaw("
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
            ->join('detail_kunjungan', 'detail_kunjungan.keluhan_id', 'keluhan.id')
            ->where('nomor_tiket', $no_tiket)
            ->with(['pasien', 'dokter.bidang'])
            ->groupBy('keluhan.id')
            ->first();
            if($ticket)
                return $this->sendResponse($ticket, 'Informasi tiket ditemukan');
            else
                return $this->sendError('Tiket ' . $no_tiket . ' tidak ditemukan', []);
        }
        catch(\Throwable $th){
            DB::rollback();
            return $this->sendError($th->getMessage(), [], 500);
        }
    }

    public function changeStatus(Request $request){
        $rules =  [
            'status' => 'required',
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
            $data = DetailKunjungan::find($request->id_kunjungan);
            $keluhan = Keluhan::find($data->keluhan_id);
            $data->status = $request->status;
            if($request->status == "belum_bayar"){
                $totalResep = ResepObat::selectRaw("
                    SUM(coalesce(masterdata_obat.harga,0) * coalesce(resep_obat.jumlah,0)) as total
                ")
                ->join('masterdata_obat', 'masterdata_obat.id', 'resep_obat.obat_id')
                ->where('detail_kunjungan_id',$data->id)->first();
                $totalPenunjang = RujukanPenunjangMedis::selectRaw("
                    COALESCE(SUM(masterdata_penunjang_medis.harga),0) as total
                ")
                ->join('masterdata_penunjang_medis', 'masterdata_penunjang_medis.id', 'rujukan_penunjang.penunjang_id')
                ->where('detail_kunjungan_id',$data->id)->first();

                $tarif = Dokter::select('bidang_dokter.tarif_konsultasi')->join('bidang_dokter', 'bidang_dokter.id', 'dokter.bidang_id')->where('dokter.id', $keluhan->dokter_id)->first();
                $data->total_harga = $totalResep->total + $totalPenunjang->total + $tarif->tarif_konsultasi;
            }
            if($request->status == "selesai"){
                $data->tanggal_bayar = Carbon::now();

                $setEnableAnotherKunjungan = DetailKunjungan::where('keluhan_id', $data->keluhan_id)->orderBy('tanggal','asc')->get();
                $setNextTrue = false;
                if(count($setEnableAnotherKunjungan) != 1){
                    foreach ($setEnableAnotherKunjungan as $key => $kj) {
                        if($kj->is_enable){
                            $kj->is_enable = false;
                            $kj->save();
                            $setNextTrue = true;
                        }
                        elseif($setNextTrue){
                            $kj->is_enable = true;
                            $kj->save();
                            $setNextTrue = false;
                        }
                    }
                }

            }
            $data->update();
            

            $keluhan->status = $request->status;
            
            $keluhan->update();
            DB::commit();
            if($request->is_from_page){
                switch ($request->status) {
                    case 'menunggu_panggilan':
                        return redirect()->back()->with('success', "Berhasil konfirmasi kehadiran");
                    break;
                    case 'masuk_ruangan':
                        return redirect()->back()->with('success', "Berhasil, pasien diinformasikan untuk masuk ruangan");
                    break;
                    case 'belum_bayar':
                        return redirect()->back()->with('success', "Berhasil, pasien diinformasikan untuk melakukan pembayaran");
                    break;
                    
                    default:
                    return redirect()->back()->with('success', "Berhasil merubah status");
                    break;
                }
            }else{
                return $this->sendResponse([], 'Berhasil merubah status');
            }
        }catch(\Exception $e){
            DB::rollback();
            if($request->is_from_page){
                return redirect()->back()->with('error', $e->getMessage());
            }
            return $this->sendError($e->getMessage(), [], 500);
        }
    }
}
