<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>SIRAJA | Validasi Ticket</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  </head>
  <body class="vh-100">
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
                            <div id="scanner-container"></div>
                        </center>
                        <br>
                        <h5 class="text-center">Validasi Tiket Anda Disini</h5>
                        <br>
                        <input type="text" name="nomor_tiket" id="" class="form-control" placeholder="Masukan nomor tiket anda">
                        <br>
                        <center>
                            <div class="d-flex justify-content-center">
                                <button class="btn btn-primary me-2">Cek Tiket</button>
                                <button class="btn btn-warning" id="btn-qr">Gunakan QR Code</button>
                            </div>
                        </center>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/quagga/dist/quagga.min.js"></script>
    <script>
        $(document).ready(function(){
            var scanner;
            var is_active = false;
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
                    scanner = Quagga.init({
                        inputStream: {
                            name: "Live",
                            type: "LiveStream",
                            target: document.querySelector('#scanner-container'),
                            constraints: {
                            width: 640,
                            height: 480,
                            facingMode: "environment"
                            },
                        },
                        decoder: {
                            readers: ["code_128_reader", "ean_reader", "ean_8_reader", "code_39_reader", "code_39_vin_reader", "codabar_reader", "upc_reader", "upc_e_reader", "i2of5_reader"]
                        }
                        }, function(err) {
                        if (err) {
                            console.error(err);
                            return;
                        }
                        // Mulai scan setelah inisialisasi selesai
                        Quagga.start();
                    });
                }else{
                    Quagga.stop();
                    // Hancurkan instansi scanner
                    scanner = null;
                    // Kosongkan konten scanner-container
                    $('#scanner-container').empty();
                }
            })
            Quagga.onDetected(function(result) {
                console.log('QR Code detected:', result);
                alert('QR Code detected: ' + result.codeResult.code);
                // Lakukan sesuatu dengan nilai QR code yang dideteksi
            });
        })
    </script>
  </body>
</html>