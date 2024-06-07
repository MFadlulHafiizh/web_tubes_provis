<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>SIRAJA | Validasi Ticket</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://unpkg.com/@zxing/library@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  </head>
  <body class="vh-100">
    @if (Session::has('success'))
        <script>
            $(document).ready(function(){
                Swal.fire({
                    title: "Berhasil",
                    text: "{{Session::get('success')}}",
                    icon: "success"
                });
            })
        </script>
    @endif
    <div class="container h-100 d-flex">
        <div class="row justify-content-center my-auto w-100">
            <div class="col-lg-8">
                <div class="card">
                    <div class="card-body">
                        <center>
                            <img src="{{asset('app_logo.svg')}}" alt="" style="width: 100px">
                        </center>
                        <br>
                        <h3 class="text-warning text-center">SIRAJA</h3>
                        <p class="lead text-warning text-center" style="font-weight: 600">Sistem Informasi Rawat Jalan</p>
                        <br>
                        <center>
                            <div id="camera-container" class="d-none">
                                <video id="previewKamera" style="width: 300px;height: 300px;"></video>
                                <select id="pilihKamera" style="max-width:400px" class="form-select">
                                </select>
                            </div>
                        </center>
                        <br>
                        <h5 class="text-center">Validasi Tiket Anda Disini</h5>
                        {{-- <input type="text" id="hasilscan"> --}}
                        <br>
                        <input type="text" name="nomor_tiket" id="in_no_tiket" class="form-control" placeholder="Masukan nomor tiket anda">
                        <br>
                        <center>
                            <div class="d-flex justify-content-center">
                                <button class="btn btn-primary me-2" id="btn-cek-manual">Cek Tiket</button>
                                <button class="btn btn-warning" id="btn-qr">Gunakan QR Code</button>
                            </div>
                        </center>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="detailJanjiTemu" tabindex="-1" aria-labelledby="detailJanjiTemuLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="detailJanjiTemuLabel">Detail Tiket</h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <table class="table table-light table-striped">
                <thead>
                    <tr>
                        <td>Nomor Tiket</td>
                        <td>:</td>
                        <td id="no_tiket"></td>
                    </tr>
                    <tr>
                        <td>Status</td>
                        <td>:</td>
                        <td id="tiket_status"></td>
                    </tr>
                    <tr>
                        <td>Nama Pasien</td>
                        <td>:</td>
                        <td id="tiket_nama_pasien"></td>
                    </tr>
                    <tr>
                        <td>Jenis Kelamin</td>
                        <td>:</td>
                        <td id="tiket_jenkel"></td>
                    </tr>
                    <tr>
                        <td>No Telp</td>
                        <td>:</td>
                        <td id="tiket_telp"></td>
                    </tr>
                    <tr>
                        <td>Tanggal</td>
                        <td>:</td>
                        <td id="tiket_tanggal"></td>
                    </tr>
                    <tr>
                        <td>Jam</td>
                        <td>:</td>
                        <td id="tiket_jam"></td>
                    </tr>
                    <tr>
                        <td colspan="3"></td>
                    </tr>
                    <tr>
                        <td>Nama Dokter</td>
                        <td>:</td>
                        <td id="tiket_dokter"></td>
                    </tr>
                    <tr>
                        <td>Bidang Dokter</td>
                        <td>:</td>
                        <td id="tiket_dokter_bidang"></td>
                    </tr>
                </thead>
              </table>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
              <form action="{{ url('change-status') }}" method="post" id="btn-confirm">
                @csrf
                <input type="hidden" name="status" id="status" value="menunggu_panggilan">
                <input type="hidden" name="id_kunjungan" id="id_kunjungan" value="">
                <input type="hidden" name="is_from_page" value="true">
                <button type="submit" class="btn btn-primary">Konfirmasi Kedatangan</button>
              </form>
            </div>
          </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/moment-with-locales.min.js" integrity="sha512-4F1cxYdMiAW98oomSLaygEwmCnIP38pb4Kx70yQYqRwLVCs3DbRumfBq82T08g/4LJ/smbFGFpmeFlQgoDccgg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script>
        let selectedDeviceId = null;
        const codeReader = new ZXing.BrowserMultiFormatReader();
        const sourceSelect = $("#pilihKamera");
        var is_active = false;
        $('#pilihKamera').change(function(){
            selectedDeviceId = $(this).val();
            if (navigator.mediaDevices) {
                if(codeReader){
                    codeReader.reset()
                    initScanner()
                }
            } else {
                alert('kamera tidak bisa di akses.');
            }
        })
        function initScanner() {
            codeReader
            .listVideoInputDevices()
            .then(videoInputDevices => {
                videoInputDevices.forEach(device =>
                            //list kamera yang tersedia (bisa di hapus)
                    console.log(`${device.label}, ${device.deviceId}`)
                );
        
                if(videoInputDevices.length > 0){
                    //cek jika kamera id tidak null
                    if(selectedDeviceId == null){
                                    
                        //memebrikan nilai kamera yang dipilih secara default
                        if(videoInputDevices.length > 0){
                            selectedDeviceId = videoInputDevices[0].deviceId
                        }
                    }  
                    //menampilkan list kamera yang ada ke list select option jadi nanti kita bisa memilih kameranya nanti
                    if (videoInputDevices.length >= 1) {
                        sourceSelect.html('');
                        videoInputDevices.forEach((element) => {
                            const sourceOption = document.createElement('option')
                            sourceOption.text = element.label
                            sourceOption.value = element.deviceId
                            if(element.deviceId == selectedDeviceId){
                                sourceOption.selected = 'selected';
                            }
                            sourceSelect.append(sourceOption)
                        })
        
                    }
                    $('#camera-container').removeClass('d-none');
                    codeReader
                    .decodeOnceFromVideoDevice(selectedDeviceId, 'previewKamera')
                    .then(result => {
                            $('#btn-qr').click()
                            checkTicket(result.text);
                    })
                    .catch(err => console.error(err));
                } else {
                    alert("Camera not found!")
                }
            })
            .catch(err => console.error(err));
        }
        
        $('#btn-qr').on('click', function(){
            if(is_active){
                is_active = false;
                $('#btn-qr').removeClass('btn-danger')
                $('#btn-qr').addClass('btn-warning')
                $('#btn-qr').html('Gunakan QR Code')
            }else{
                is_active = true;
                $('#btn-qr').removeClass('btn-warning')
                $('#btn-qr').addClass('btn-danger')
                $('#btn-qr').html('Batal')
            }
            if(is_active){
                initScanner()

            }else{
                $('#camera-container').addClass('d-none');
                codeReader.reset()
            }
        })

        $('#btn-cek-manual').on('click', function(){
            checkTicket($('#in_no_tiket').val())
        })
        function showLoading(){
            swal.fire({
                title: "Loading",
                html: "Mohon tunggu sesaat",
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading();
                }

            })
        }
        function checkTicket(no_ticket){
            let timerInterval;
        
            showLoading()
            $.ajax({
                method: 'get',
                url: "{{url('api/info-janji-temu/validate')}}" + "/" + no_ticket,
                success: function(res){
                    swal.close()
                    let data = res.data
                    $('#no_tiket').html(data.nomor_tiket)
                    $('#tiket_status').html(data.status)
                    $('#tiket_nama_pasien').html(data.pasien.name)
                    $('#tiket_jenkel').html(data.pasien.jenkel)
                    $('#tiket_telp').html(data.pasien.no_telp)
                    $('#tiket_tanggal').html(moment(data.tanggal).format('D MMMM YYYY'))
                    $('#tiket_jam').html(data.jam)
                    $('#tiket_dokter').html(data.dokter.nama_dokter)
                    $('#tiket_dokter_bidang').html(data.dokter.bidang.bidang)
                    $('#id_kunjungan').val(data.id_kunjungan)
                    if(data.status == "sudah_waktunya"){
                        $('#btn-confirm').removeClass('d-none')
                    }else{
                        $('#btn-confirm').addClass('d-none')
                    }
                    $('#detailJanjiTemu').modal('show');
                },
                error: function(res){
                    swal.close()
                    Swal.fire({
                        title: "Error",
                        text: res.responseJSON.message,
                        icon: "error"
                    });
                    console.log(res)
                }
            })
        }
    </script>
  </body>
</html>