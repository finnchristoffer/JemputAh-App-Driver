import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jemputah_app_driver/constants/color.dart';

void main() => runApp(const Tukar());

class Tukar extends StatelessWidget {
  const Tukar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TukarPage(),
    );
  }
}

class TukarPage extends StatefulWidget {
  const TukarPage({super.key});

  @override
  _TukarPageState createState() => _TukarPageState();
}

class _TukarPageState extends State<TukarPage> {
  @override
  Widget build(BuildContext context) {
    //variable contain int number point
    var price;
    int point = 1000;

    void _calculateMoney(val) {
      setState(() {
        price = val;
        print(price);
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
                  "Total Poin",
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
                  point.toString() + "   Koin",
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
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Text(
                    "Masukan jumlah koin \nyang ingin anda tukar",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
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
                      // child: Text(
                      //   point.toString(),
                      //   style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      child: TextField(
                        // controller: valuePoint,
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
        ],
      ),
    );
  }
}
