<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\User;
use App\Models\Pasien;
use App\Models\Keluhan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use SimpleSoftwareIO\QrCode\Facades\QrCode;

class PasienController extends Controller
{
    public function getList(Request $request){
        try{
            $data = Pasien::query();
            if($request->user_id)
                $data->where('user_id', $request->user()->id);
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
            'email' => 'email|unique:users,email',
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
                }
            }
            $newKeluarga->user_id = $request->user()->id;
            $newKeluarga->nik = $request->nik ?? $newKeluarga->nik;
            $newKeluarga->name = $request->name ?? $newKeluarga->name;
            $newKeluarga->jenkel = $request->jenkel ?? $newKeluarga->jenkel;
            $newKeluarga->tgl_lahir = $request->tgl_lahir ?? $newKeluarga->tgl_lahir;
            $newKeluarga->tempat_lahir = $request->tempat_lahir ?? $newKeluarga->tempat_lahir;
            $newKeluarga->no_telp = $request->no_telp ?? $newKeluarga->no_telp;
            $newKeluarga->is_default = true;
            if($request->hasFile('foto')){
                $file = $request->file('foto');
                $originalName = $file->getClientOriginalName();
                $filename = $account->id . '_' .date('dmYhis') . $originalName;
                $file->storeAs('account/user_image/', $filename, "public");
                $newKeluarga->foto = 'account/user_image/'.$filename;
            }
            if($request->hasFile('file_bpjs')){
                $file = $request->file('file_bpjs');
                $originalName = $file->getClientOriginalName();
                $filename = $account->id . '_' .date('dmYhis') . $originalName;
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
            $image = QrCode::size(200)
                ->generate(env('PUBLIC_IP') . '/info-janji-temu/validate/' .$ticketCode);
            $url_image = 'tiket_pasien/'. $ticketCode . '.svg';
            Storage::disk('public')->put($url_image, $image);
            $janjiTemu->qr_code = $url_image;
            $janjiTemu->status = 'Akan Datang';
            $janjiTemu->save();
            DB::commit();
            $ticket = $janjiTemu->with(['pasien'])->first();
            return $this->sendResponse($ticket, 'Berhasil membuat janji temu');
        }catch(\Throwable $th){
            DB::rollback();
            return $this->sendError($th->getMessage(), [], 500);
        }
    }

    public function getListJanjiTemu(Request $request){
        try{
            $allPasienFromUser = Pasien::where('user_id', $request->user()->id)->pluck('id');
            $janjiTemu = Keluhan::whereIn('pasien_id', $allPasienFromUser->toArray())->with(['pasien', 'dokter.bidang'])->get();
            return $this->sendResponse($janjiTemu, 'Data berhasil diambil');
        }
        catch(\Throwable $th){
            DB::rollback();
            return $this->sendError($th->getMessage(), [], 500);
        }
    }

    public function indexValidasiKehadiran(Request $request){
        return view('validasi_page');
    }

    public function cekJanjiTemu($no_tiket){
        try{
            $ticket = Keluhan::where('nomor_tiket', $no_tiket)->with(['pasien', 'jadwalDokter.dokter', 'jadwalDokter.ruangan'])->first();
            if($ticket)
                return $this->sendResponse($ticket, 'Informasi tiket ditemukan');
            else
                return $this->sendResponse([], 'Tiket tidak ditemukan');
        }
        catch(\Throwable $th){
            DB::rollback();
            return $this->sendError($th->getMessage(), [], 500);
        }
    }
}
