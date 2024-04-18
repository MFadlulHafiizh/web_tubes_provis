<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Pasien;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class PasienController extends Controller
{
    public function getList(Request $request){
        try{
            $data = Pasien::query();
            if($request->user_id)
                $data->where('user_id', $request->user_id);
            if($request->is_keluarga == "true")
                $data->where('is_default', false);
            
            $data = $data->get();
            return $this->sendResponse($data, "Data berhasil diambil");
        }catch(\Exception $e){
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
}
