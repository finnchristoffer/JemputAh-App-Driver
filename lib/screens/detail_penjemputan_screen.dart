import 'package:flutter/material.dart';
import 'package:jemputah_app_driver/API/FetchData.dart';
import 'package:jemputah_app_driver/constants/color.dart';
import 'package:jemputah_app_driver/constants/icons.dart';
import 'package:jemputah_app_driver/constants/variable.dart';
import 'package:jemputah_app_driver/extensions/time_code_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jemputah_app_driver/screens/base_screen.dart';

class DetailPenjemputanScreen extends StatefulWidget {
  final String idJemput;

  const DetailPenjemputanScreen(this.idJemput, {super.key});

  @override
  State<StatefulWidget> createState() => InitState(idJemput);
}

class InitState extends State<DetailPenjemputanScreen> {
  var db = FirebaseFirestore.instance;
  String idJemput;

  InitState(this.idJemput);

  dynamic _beratSampahPlastik = 0.0;
  dynamic _beratSampahKarton = 0.0;
  dynamic _beratSampahKaca = 0.0;
  dynamic _beratSampahKaleng = 0.0;

  dynamic _totalPendapatanDriver = 0;
  dynamic _totalPendapatanUser = 0;
  double _totalBerat = 0;

  String _alamatPenjemputan = 'Loading...';
  String _tanggalPenjemputan = 'Loading...';
  String _waktuPenjemputan = 'Loading...';
  String _namaUser = 'Loading...';
  String _noTelpUser = 'Loading...';

  dynamic _koinUser = 0;
  dynamic _jemputUser = 0;
  dynamic _beratUser = 0;

  dynamic _koinDriver = 0;
  dynamic _jemputDriver = 0;
  dynamic _beratDriver = 0;

  int _timeCode = 0;

  String _idSampah = '';
  String _idUser = '';

  TimeCodeConverter timeCodeConverter = TimeCodeConverter();

  void setJemput() {
    var jemput = FetchData().fetchMapData('jemput', idJemput);
    jemput.then((value) {
      setState(() {
        _totalPendapatanDriver = value['total_koin_driver'];
        _totalPendapatanUser = value['total_koin_user'];
        _totalBerat = value['total_berat'];
        _idSampah = value['id_sampah'];
        _alamatPenjemputan = value['address'];
        _tanggalPenjemputan = value['date'];
        _idUser = value['id_user'];
        _timeCode = value['time_code'];
        _waktuPenjemputan =
            timeCodeConverter.timeCodeConverter(value['time_code']);
        setSampah();
        setUser();
        setDriver();
      });
    });
  }

  void setSampah() {
    var sampah = FetchData().fetchMapData('sampah', _idSampah);
    sampah.then((value) {
      setState(() {
        _beratSampahPlastik = value['berat1'].toDouble();
        _beratSampahKarton = value['berat2'].toDouble();
        _beratSampahKaca = value['berat3'].toDouble();
        _beratSampahKaleng = value['berat4'].toDouble();
      });
    });
  }

  void setUser() {
    var user = FetchData().fetchMapData('user', _idUser);
    user.then((value) {
      setState(() {
        _namaUser = value['name_user'];
        _noTelpUser = value['phone_num_user'];
        _koinUser = value['jml_koin_user'];
        _jemputUser = value['jml_jemput'];
        _beratUser = value['jml_berat'];
      });
    });
  }

  void setDriver() {
    var driver = FetchData().fetchMapData('driver', uid);
    driver.then((value) {
      setState(() {
        _koinDriver = value['jml_koin_driver'];
        _jemputDriver = value['jml_jemput'];
        _beratDriver = value['jml_berat'];
      });
    });
  }

  void setDone() {
    final jemput = <String, dynamic>{
      "done": true,
    };
    db.collection('jemput').doc(idJemput).update(jemput);
    final updateDriver = <String, dynamic>{
      "jml_koin_driver": _koinDriver + _totalPendapatanDriver,
      "jml_jemput": _jemputDriver + 1,
      "jml_berat": _beratDriver + _totalBerat,
    };
    db.collection('driver').doc(uid).update(updateDriver);
    final updateUser = <String, dynamic>{
      "jml_koin_user": _koinUser + _totalPendapatanUser,
      "jml_jemput": _jemputUser + 1,
      "jml_berat": _beratUser + _totalBerat,
    };
    db.collection('user').doc(_idUser).update(updateUser);
    db.collection('driver').doc(uid).update({'slot_$_timeCode': ''});
  }

  @override
  void initState() {
    setJemput();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 246, 233, 1),
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: AppColors.mainGreen,
        title: const Text('Detail Pesanan'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.separatorLine,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  margin: const EdgeInsets.only(top: 10, left: 24, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _namaUser,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, right: 24, bottom: 10),
                  child:
                      Text((_noTelpUser), style: const TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 24, top: 10),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Jenis Sampah Daur Ulang :',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Container(
              height: 42,
              margin: const EdgeInsets.only(left: 24, right: 24, top: 5),
              padding: const EdgeInsets.only(left: 10, right: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(178, 186, 159, 1),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    width: 34,
                    height: 34,
                    child: Image.asset(
                      iconPlastik,
                    ),
                  ),
                  const SizedBox(
                    width: 220,
                    child: Text('Plastik'),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Text("$_beratSampahPlastik"),
                        const Text(' Kg'),
                      ],
                    ),
                  ),
                ],
              )),
          Container(
              height: 42,
              margin: const EdgeInsets.only(left: 24, right: 24, top: 8),
              padding: const EdgeInsets.only(left: 10, right: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(178, 186, 159, 1),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    width: 34,
                    height: 34,
                    child: Image.asset(
                      iconKarton,
                    ),
                  ),
                  const SizedBox(
                    width: 220,
                    child: Text('Karton'),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Text("$_beratSampahKarton"),
                        const Text(' Kg'),
                      ],
                    ),
                  ),
                ],
              )),
          Container(
              height: 42,
              margin: const EdgeInsets.only(left: 24, right: 24, top: 8),
              padding: const EdgeInsets.only(left: 10, right: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(178, 186, 159, 1),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    width: 34,
                    height: 34,
                    child: Image.asset(
                      iconKaca,
                    ),
                  ),
                  const SizedBox(
                    width: 220,
                    child: Text('Kaca'),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Text("$_beratSampahKaca"),
                        const Text(' Kg'),
                      ],
                    ),
                  ),
                ],
              )),
          Container(
              height: 42,
              margin: const EdgeInsets.only(left: 24, right: 24, top: 8),
              padding: const EdgeInsets.only(left: 10, right: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(178, 186, 159, 1),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    width: 34,
                    height: 34,
                    child: Image.asset(
                      iconKaleng,
                    ),
                  ),
                  const SizedBox(
                    width: 220,
                    child: Text('Kaleng'),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Text("$_beratSampahKaleng"),
                        const Text(' Kg'),
                      ],
                    ),
                  ),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5, right: 24),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Total Berat :',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, right: 35),
                child: Text(("$_totalBerat Kg"),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 24, top: 15),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Lokasi Pengambilan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Container(
              height: 42,
              margin: const EdgeInsets.only(left: 24, right: 24, top: 8),
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(178, 186, 159, 1),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 34,
                  height: 34,
                  child: const Icon(Icons.location_on),
                ),
                SizedBox(
                    width: 260,
                    child: Text(
                      _alamatPenjemputan,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 15),
                    )),
              ])),
          Container(
            margin: const EdgeInsets.only(left: 24, top: 15),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Tanggal Pengambilan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Container(
              height: 42,
              margin: const EdgeInsets.only(left: 24, right: 24, top: 8),
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(178, 186, 159, 1),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 34,
                  height: 34,
                  child: const Icon(Icons.calendar_month),
                ),
                SizedBox(
                    width: 260,
                    child: Text(
                      _tanggalPenjemputan,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 15),
                    )),
              ])),
          Container(
            margin: const EdgeInsets.only(left: 24, top: 15),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Waktu Pengambilan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Container(
              height: 42,
              margin: const EdgeInsets.only(left: 24, right: 24, top: 8),
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(178, 186, 159, 1),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 34,
                  height: 34,
                  child: const Icon(Icons.timer),
                ),
                SizedBox(
                    width: 260,
                    child: Text(
                      _waktuPenjemputan,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 15),
                    )),
              ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 25, left: 24),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Total Pendapatan Anda',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25, right: 24),
                child: Text(("$_totalPendapatanDriver Koin"),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => {
                    //buat cancel pesanan nanti ditaro disini
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 30),
                    width: 170,
                    alignment: Alignment.center,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)),
                      ],
                    ),
                    child: const Text(
                      'Batalkan Pesanan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    setDone(),
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BaseScreen())),
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Berhasil",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                            backgroundColor: AppColors.secondaryBorder,
                            content: const Text(
                              "Pesanan sudah diselesaikan.",
                              textAlign: TextAlign.center,
                            ),
                          );
                        }),
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 30),
                    width: 170,
                    alignment: Alignment.center,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(62, 75, 42, 1),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)),
                      ],
                    ),
                    child: const Text(
                      'Pesanan Selesai',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
