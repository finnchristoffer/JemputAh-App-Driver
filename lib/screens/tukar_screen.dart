import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jemputah_app_driver/API/FetchData.dart';
import 'package:jemputah_app_driver/constants/color.dart';
import 'package:jemputah_app_driver/constants/variable.dart';
import 'package:jemputah_app_driver/extensions/date_time_converter.dart';
import 'package:jemputah_app_driver/models/driver.dart';
import 'package:jemputah_app_driver/screens/home_screen.dart';

void main() => runApp(const TukarScreen());

class TukarScreen extends StatefulWidget {
  const TukarScreen({super.key});

  @override
  _TukarScreenState createState() => _TukarScreenState();
}

int price = 0;
int point = 0;

class _TukarScreenState extends State<TukarScreen> {
  var db = FirebaseFirestore.instance;
  var jml_koin_driver = 0;
  var dateNow = DateTime.now().toString();
  DateTimeConverter dateTimeConverter = DateTimeConverter();

  void setDriver() {
    var user = FetchData().fetchMapData("driver", uid);
    user.then((value) {
      setState(() {
        jml_koin_driver = value["jml_koin_driver"];
      });
    });
  }

  void uploadTransaction(int i) {
    final DriverTransaction = <String, dynamic>{
      'id_driver': uid,
      'tgl_transaksi_user': dateTimeConverter.formatWithoutDay(dateNow),
      'koin_tukar': point,
      'rupiah': price,
    };
    db.collection('driver_transaction').add(DriverTransaction);
  }

  void updatePointDriver(int i) {
    var updatePoint = jml_koin_driver - i;
    db.collection('driver').doc(uid).update({'jml_koin_driver': updatePoint});
  }

  @override
  void initState() {
    super.initState();
    setDriver();
  }

  @override
  Widget build(BuildContext context) {
    void _calculateMoney(val) {
      setState(() {
        if (val != "") {
          point = int.parse(val);
          price = point * 100;
        } else {
          price = 0;
        }
      });
    }

    TextEditingController valuePoint = TextEditingController();
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
                margin: EdgeInsets.only(top: 40, left: 45),
                child: Text(
                  "Total Koin",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(top: 40, right: 60),
                child: Text(
                  jml_koin_driver.toString() + "   Koin",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 25, left: 30, right: 30),
            decoration: BoxDecoration(
              color: AppColors.secondaryBorder,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 80, left: 45),
                      child: Text(
                        "Koin",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(top: 80, right: 55),
                      width: 150,
                      child: TextField(
                        onChanged: (val) {
                          _calculateMoney(val);
                        },
                        decoration: new InputDecoration.collapsed(
                            hintText: 'Jumlah Koin'),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Container(
                    height: 2.0,
                    width: 290.0,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 25, left: 50, bottom: 65),
                      child: Text(
                        "Rp.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(top: 25, right: 50, bottom: 65),
                      child: Text(
                        '$price',
                        style: TextStyle(
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
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () {
              uploadTransaction(price);
              updatePointDriver(point);
              price = 0;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return const HomeScreen();
                  },
                ),
              );
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
