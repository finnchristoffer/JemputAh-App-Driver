import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jemputah_app_driver/API/FetchData.dart';
import 'package:jemputah_app_driver/components/dl_alert.dart';
import 'package:jemputah_app_driver/constants/color.dart';
import 'package:jemputah_app_driver/constants/variable.dart';
import 'package:jemputah_app_driver/extensions/date_time_converter.dart';
import 'package:jemputah_app_driver/screens/base_screen.dart';

void main() => runApp(const TukarScreen());

class TukarScreen extends StatefulWidget {
  const TukarScreen({super.key});

  @override
  TukarScreenState createState() => TukarScreenState();
}

int price = 0;
int point = 0;

class TukarScreenState extends State<TukarScreen> {
  var db = FirebaseFirestore.instance;
  var jmlKoinDriver = 0;
  var dateNow = DateTime.now().toString();
  DateTimeConverter dateTimeConverter = DateTimeConverter();

  void setDriver() {
    var user = FetchData().fetchMapData("driver", uid);
    user.then((value) {
      setState(() {
        jmlKoinDriver = value["jml_koin_driver"];
      });
    });
  }

  void uploadTransaction(int i) {
    final driverTransaction = <String, dynamic>{
      'id_driver': uid,
      'tgl_transaksi_driver': dateTimeConverter.formatWithoutDay(dateNow),
      'koin_tukar': point,
      'rupiah': price,
    };
    db.collection('driver_transaction').add(driverTransaction);
  }

  void updatePointDriver(int i) {
    var updatePoint = jmlKoinDriver - i;
    db.collection('driver').doc(uid).update({'jml_koin_driver': updatePoint});
  }

  void validationCoin(int i) {
    if (jmlKoinDriver < point) {
      const snackBar = SnackBar(
        content: Text('Koin anda tidak mencukupi'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      uploadTransaction(price);
      updatePointDriver(point);
      price = 0;
      showUp();
    }
  }

  void alert() {
    final alertTitles = ["Konfirmasi"];
    final alertDetailPesanan =
        "Apakah anda yakin ingin melakukan penukaran dengan koin sejumlah " +
            point.toString() +
            "?";
    DLAlert(
        cancelTitle: 'Batalkan',
        alertTitle: 'Konfirmasi Penukaran',
        alertDetailMessage: alertDetailPesanan,
        alertActionTitles: alertTitles,
        onAlertAction: (int selectedActionIndex) {
          validationCoin(point);
        }).show(context);
  }

  void showUp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return const BaseScreen();
        },
      ),
    );
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
              "Koin anda berhasil ditukar.",
              textAlign: TextAlign.center,
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    setDriver();
  }

  @override
  Widget build(BuildContext context) {
    void calculateMoney(val) {
      setState(() {
        if (val != "") {
          point = int.parse(val);
          price = point * 10;
        } else {
          price = 0;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainGreen,
        title: const Text('Tukar Koin'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40, left: 45),
                child: const Text(
                  "Total Koin",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(top: 40, right: 60),
                child: Text(
                  "$jmlKoinDriver   Koin",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 25, left: 30, right: 30),
            decoration: BoxDecoration(
              color: AppColors.secondaryBorder,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 80, left: 45),
                      child: const Text(
                        "Koin",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(top: 80, right: 55),
                      width: 150,
                      child: TextField(
                        onChanged: (val) {
                          calculateMoney(val);
                        },
                        decoration: const InputDecoration.collapsed(
                            hintText: 'Jumlah Koin'),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Container(
                    height: 2.0,
                    width: 290.0,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 25, left: 50, bottom: 65),
                      child: const Text(
                        "Rp.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 25, right: 50, bottom: 65),
                      child: Text(
                        '$price',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () {
              alert();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonBackground,
              minimumSize: const Size(225, 40),
            ),
            child: const Text("KONFIRMASI"),
          ),
        ],
      ),
    );
  }
}
