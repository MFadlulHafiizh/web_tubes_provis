@extends('dokter.base_layout')
@section('title_section', 'Input Diagnosa Hasil Pemeriksaan')
@section('pekerjaan', 'show')
@section('daftar_pasien', 'active')
@section('content')
@php
    use Carbon\Carbon;
@endphp
<div class="container">
    <div class="row">
        <div class="col-lg-6">
            <div class="card h-100">
                <div class="card-header">
                    <div class="card-title">
                        <h3>Biodata Pasien</h3>
                    </div>
                    <div class="text-end my-auto badge badge-success">{{$data->status}}</div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-6">
                            <img src="{{Storage::url($data->pasien->foto)}}" alt="" class="rounded" style="width: 100%">
                        </div>
                        <div class="col-6">
                            <table>
                                <tr>
                                    <td>Nama</td>
                                    <td>:</td>
                                    <td>{{$data->pasien->name}}</td>
                                </tr>
                                <tr>
                                    <td>Usia</td>
                                    <td>:</td>
                                    <td>{{Carbon::now()->diffInYears(Carbon::parse($data->pasien->tgl_lahir))}}</td>
                                </tr>
                                <tr>
                                    <td>No Telp</td>
                                    <td>:</td>
                                    <td>{{$data->pasien->no_telp}}</td>
                                </tr>
                                <tr>
                                    <td>Jenis Kelamin</td>
                                    <td>:</td>
                                    <td>{{$data->pasien->jenkel}}</td>
                                </tr>
                                <tr>
                                    <td>BPJS</td>
                                    <td>:</td>
                                    <td>{{$data->is_bpjs == true ? 'Ya' : 'Tidak'}}</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="card h-100">
                <div class="card-header">
                    <div class="card-title">
                        <h3>Detail Keluhan</h3>
                    </div>
                    <div class="text-end my-auto">
                        @if ($data->status != "belum_bayar")
                            @if ($data->status == 'menunggu_panggilan')
                            <form action="{{url('change-status')}}" method="post">
                                @csrf
                                <input type="hidden" name="id_kunjungan" value="{{$data->id_kunjungan}}">
                                <input type="hidden" name="status" value="masuk_ruangan">
                                <input type="hidden" name="is_from_page" value="true">
                                <button type="submit" class="btn btn-info">Panggil</button>
                            </form>
                            @else
                            <form action="{{url('change-status')}}" method="post">
                                @csrf
                                <input type="hidden" name="id_kunjungan" value="{{$data->id_kunjungan}}">
                                <input type="hidden" name="status" value="belum_bayar">
                                <input type="hidden" name="is_from_page" value="true">
                                <button type="submit" class="btn btn-info">Selesai</button>
                            </form>
                            @endif

                        @endif
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <p class="lead">
                            {{$data->detail_keluhan}}
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row mt-5">
        <div class="col">
            <div class="card ">
                <div class="card-header card-header-stretch">
                    <h3 class="card-title">Hasil Analisis</h3>
                    <div class="card-toolbar">
                        <ul class="nav nav-tabs nav-line-tabs nav-stretch fs-6 border-0">
                            <li class="nav-item">
                                <a class="nav-link active" data-bs-toggle="tab" href="#diagnosa">Diagnosa</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-bs-toggle="tab" href="#resep_obat">Resep Obat</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-bs-toggle="tab" href="#penunjang">Penunjang</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-bs-toggle="tab" href="#rawat_jalan">Rawat Jalan</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="card-body">
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade show active" id="diagnosa" role="tabpanel">
                            <form action="{{route('dokter.diagnosa.storeUpdate')}}" method="post">
                                @csrf
                                <input type="hidden" name="id_kunjungan" value="{{$data->id_kunjungan}}">
                                <textarea name="diagnosa" class="form-control" rows="10" placeholder="Masukan hasil diagnosa">{{ $data->diagnosa }}</textarea>
                                <div class="d-flex mt-5">
                                    <button type="submit" class="btn btn-primary ms-auto">Simpan</button>
                                </div>
                            </form>
                        </div>
            
                        <div class="tab-pane fade" id="resep_obat" role="tabpanel">
                            <div class="container">
                                <div class="row justify-content-between">
                                    <div class="col-lg-5">
                                        <form action="{{route('dokter.resep-obat.store')}}" method="post">
                                            @csrf
                                            <select class="form-select mt-5" name="obat_id" id="inputGroupSelect04" aria-label="Example select with button addon">
                                                <option selected disabled>Pilih Obat</option>
                                                @foreach ($obat as $item)
                                                    <option value="{{$item->id}}">{{$item->nama_obat}}</option>
                                                @endforeach
                                            </select>
                                            <input type="hidden" name="detail_kunjungan_id" value="{{$data->id_kunjungan}}">
                                            <input type="number" name="jumlah" id="" class="form-control mt-5" placeholder="Jumlah">
                                            <textarea name="keterangan" class="form-control mt-5" rows="5" placeholder="Masukan keterangan"></textarea>
                                            <button class="btn btn-success w-100 mt-5">Tambah Obat</button>
                                        </form>
                                    </div>
                                    <div class="col-lg-6">
                                        <table class="table table-bordered table-primary table-striped gx-5">
                                            <thead>
                                                <tr>
                                                    <th>No</th>
                                                    <th>Nama Obat</th>
                                                    <th>Jumlah</th>
                                                    <th>Keterangan</th>
                                                    <th>Aksi</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                @if (count($resepObat) == 0)
                                                    <tr>
                                                        <td colspan="5" class="text-center">Data belum tersedia</td>
                                                    </tr>
                                                @endif
                                                @foreach ($resepObat as $item)
                                                    <tr>
                                                        <td>{{$loop->iteration}}</td>
                                                        <td>{{$item->masterObat->nama_obat}}</td>
                                                        <td>{{$item->jumlah}}</td>
                                                        <td>{{$item->keterangan}}</td>
                                                        <td>
                                                            <form action="{{route('dokter.resep-obat.delete')}}" method="post">
                                                                @method('DELETE')
                                                                @csrf
                                                                <input type="hidden" name="resep_id" value="{{$item->id}}">
                                                                <button type="submit" class="btn btn-sm btn-danger">-</button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                @endforeach
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
            
                        <div class="tab-pane fade" id="penunjang" role="tabpanel">
                            <h3>Rujukan Penunjang Medis</h3>
                            <form class="input-group mb-3" method="post" action="{{route('dokter.penunjang-medis.store')}}">
                                @csrf
                                <select class="form-select" name="penunjang_id" id="inputGroupSelect04" aria-label="Example select with button addon">
                                    <option selected disabled>Pilih Penunjang Medis Yang Dibutuhkan</option>
                                    @foreach ($penunjangMedis as $item)
                                        <option value="{{$item->id}}">{{$item->jenis_penunjang_medis}}</option>
                                    @endforeach
                                </select>
                                <input type="hidden" name="detail_kunjungan_id" value="{{$data->id_kunjungan}}">
                                <button type="submit" class="btn btn-primary" type="button" id="button-addon2">tambah</button>
                            </form>
                            <table class="table table-primary table-striped gx-5">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Penunjang Medis Dibutuhkan</th>
                                        <th>Aksi</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @if (count($rujukanPenunjang) == 0)
                                    <tr>
                                        <td colspan="3" class="text-center">Data belum tersedia</td>
                                    </tr>
                                    @endif
                                    @foreach ($rujukanPenunjang as $item)
                                        <tr>
                                            <td>{{$loop->iteration}}</td>
                                            <td>{{$item->masterPenunjangMedis->jenis_penunjang_medis}}</td>
                                            <td>
                                                <div class="d-flex">
                                                    <form action="{{route('dokter.penunjang-medis.delete')}}" method="post">
                                                        @method('DELETE')
                                                        @csrf
                                                        <input type="hidden" name="penunjang_id" value="{{$item->id}}">
                                                        <button type="submit" class="btn btn-sm btn-danger">-</button>
                                                    </form>
                                                    @if ($item->hasil_penunjang != null)
                                                    <a href="{{Storage::url($item->hasil_penunjang)}}" target="_blank" class="btn btn-sm btn-warning ms-2">Lihat Lampiran</a>
                                                    @endif
                                                </div>
                                            </td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                            <br>
                            <hr>
                            <br>
                            <h3>Hasil Penunjang Medis</h3>
                            <p class="lead">Belum ada hasil</p>
                            <embed src="" type="">
                        </div>
                        <div class="tab-pane fade" id="rawat_jalan" role="tabpanel">
                            <form action="{{route('dokter.rawat-jalan.storeupdate', ['is_json' => 'false'])}}" method="post">
                                @csrf
                                <input type="hidden" name="keluhan_id" value="{{$data->id}}">
                                <div class="mb-3">
                                    <label for="exampleFormControlInput1" class="form-label">Agenda</label>
                                    <input type="text" name="agenda" class="form-control" value="Kunjungan Rutin">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleFormControlInput1" class="form-label">Agenda</label>
                                    <input type="date" name="tanggal" class="form-control">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleFormControlInput1" class="form-label">Jam</label>
                                    <input type="time" name="jam" class="form-control">
                                </div>
                                <div class="d-flex mt-5">
                                    <button class="btn btn-primary ms-auto">Simpan</button>
                                </div>
                            </form>
                            <hr>
                            <table class="table table-primary table-striped">
                                <thead>
                                    <tr>
                                        <th>Agenda</th>
                                        <th>Tanggal</th>
                                        <th>Jam</th>
                                        <th>Status</th>
                                        <th>Aksi</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($data->kunjungan as $item)
                                        <tr>
                                            <td>{{$item->agenda}}</td>
                                            <td>{{Carbon::parse($item->tanggal)->translatedFormat('d M Y')}}</td>
                                            <td>{{Carbon::parse($item->jam)->translatedFormat('H:i')}}</td>
                                            <td>{{$item->id == $data->id_kunjungan ? "Sedang berlangsung" : $item->status}}</td>
                                            <td>
                                                @if ($item->id != $data->id_kunjungan)
                                                    <button class="btn btn-sm btn-danger">-</button>
                                                @else
                                                -
                                                @endif
                                            </td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
@push('js')
    <script>
        $('.nav-tabs a[data-bs-toggle="tab"]').on('shown.bs.tab', function(event) {
            let activeTab = $(event.target), // activated tab
            id = activeTab.attr('href'); // active tab href
            // set id in html5 localstorage for later usage
            localStorage.setItem('activeTab', id);

        });
        window.onload = function() {
            let tabID = localStorage.getItem('activeTab');
            $('a[href="' + tabID + '"]').tab('show');
        };
    </script>
@endpush