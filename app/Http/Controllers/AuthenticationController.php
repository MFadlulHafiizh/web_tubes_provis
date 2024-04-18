<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Pasien;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Laravel\Sanctum\PersonalAccessToken;
use Illuminate\Support\Facades\Validator;

class AuthenticationController extends Controller
{
    public function register(Request $request){
        $rules =  [
            'name' => 'required',
            'email' => 'required|email|unique:users,email',
            'password' => 'required',
            'role' => 'in:user,dokter,fo,farmasi,penunjang_medis',
            'nik' => 'required|integer',
            'jenkel' => 'required|in:Laki-laki,Perempuan',
            'tgl_lahir' => 'required|date',
            'tempat_lahir' => 'required|exists:kota,uid_kota',
            'no_telp' => 'required',
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
            $account = new User;
            $account->name = $request->name;
            $account->email = $request->email;
            $account->password = bcrypt($request->password);
            $account->salt = $request->password;
            $account->role = $request->role ?? 'user';
            if($account->save()){
                $userInfo = new Pasien;
                $userInfo->user_id = $account->id;
                $userInfo->nik = $request->nik;
                $userInfo->name = $request->name;
                $userInfo->jenkel = $request->jenkel;
                $userInfo->tgl_lahir = $request->tgl_lahir;
                $userInfo->tempat_lahir = $request->tempat_lahir;
                $userInfo->no_telp = $request->no_telp;
                $userInfo->is_default = true;
                if($request->hasFile('foto')){
                    $file = $request->file('foto');
                    $originalName = $file->getClientOriginalName();
                    $filename = $account->id . '_' .date('dmYhis') . $originalName;
                    $file->storeAs('account/user_image/', $filename, "public");
                    $userInfo->foto = 'account/user_image/'.$filename;
                }
                if($request->hasFile('file_bpjs')){
                    $file = $request->file('file_bpjs');
                    $originalName = $file->getClientOriginalName();
                    $filename = $account->id . '_' .date('dmYhis') . $originalName;
                    $file->storeAs('account/bpjs/', $filename, "public");
                    $userInfo->file_bpjs = 'account/bpjs/'.$filename;
                }
                $userInfo->save();
            }
            DB::commit();
            return $this->sendResponse([], 'Berhasil registrasi, silahkan lakukan login');
        }catch(\Thrwable $th){
            DB::rollback();
            return $this->sendError($th->getMessage(), [], 500);
        }        
    }
    public function login(Request $request)
    {
        try {
            $validator = Validator::make($request->all(),[
                'email' => 'required|email',
                'password' => 'required',
            ]);
    
            if($validator->fails()){
                $fieldsWithErrorMessagesArray = $validator->messages()->get('*');
                $messages = [];
                foreach($fieldsWithErrorMessagesArray as $mess){
                    array_push($messages, $mess);
                }
                return $this->sendError('Periksa data yang anda isi!', $messages, 400);
            }
    
            if(Auth::attempt($request->only(['email', 'password']))){
                $user = User::where('email', $request->email)->with('detailProfile')->first();
                $success['token'] =  $user->createToken('API_TOKEN')->plainTextToken;
                $success['user_info'] =  $user;
                return $this->sendResponse($success, 'User berhasil login');
            }
            else{
                return $this->sendError('Unauthorised.', ['error'=>'Email atau password salah']);
            }
        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage(), [], 500);
        }
    }
    public function getUserInfo(Request $request){
        try {
            $data = PersonalAccessToken::where('token', request()->user()->currentAccessToken()->token)->first();
            if ($data) {
                $user_info = User::with('detailProfile')->where('id', $data->tokenable_id);
                $user_info = $user_info->first();
                return $this->sendResponse($user_info, 'Data berhasil diambil');
            }else{
                return $this->sendError('Token tidak ditemukan', [], 400);
            }
        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage(), [], 500);
        }
    }
    public function logout(Request $request){
        try{
            $user = $request->user()->currentAccessToken()->delete();
            return $this->sendResponse($user, 'User logout');
        }catch(\Throwable $th){
            return $this->sendError($th->getMessage(), [], 500);
        }
    }
}
