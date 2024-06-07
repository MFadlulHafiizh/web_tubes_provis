@extends('dokter.base_layout')
@section('title_section', 'Daftar Pasien')
@section('pekerjaan', 'show')
@section('daftar_pasien', 'active')
@section('content')
    <div class="container">
        <div class="card">
            <div class="card-header">

            </div>
            <div class="card-body">
                <table class="table table-striped table-primary gx-7">
                    <thead>
                        <tr class="text-center">
                            <th>No</th>
                            <th>Nama Pasien</th>
                            <th>Waktu</th>
                            <th>Status</th>
                            <th>Tiket</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($data as $item)
                            <tr class="text-center">
                                <td>{{ $loop->iteration }}</td>
                                <td>{{ $item->pasien->name }}</td>
                                <td>{{ Carbon\Carbon::parse($item->tanggal)->translatedFormat('d M Y')}}, {{Carbon\Carbon::parse($item->jam)->format('H:i')}} WIB</td>
                                <td>{{ $item->status }}</td>
                                <td>
                                    <center>
                                        <img src="{{Storage::url($item->qr_code)}}" alt="" style="width: 50px">
                                        <p class="mt-2">{{$item->nomor_tiket}}</p>
                                    </center>
                                </td>
                                <td>
                                    <center>
                                        <a href="{{route('dokter.input-diagnosa', ['id_keluhan' => $item->id])}}" class="btn btn-sm btn-warning">Detail</a>
                                    </center>
                                </td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </div>
@endsection