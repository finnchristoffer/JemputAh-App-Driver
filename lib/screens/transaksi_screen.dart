import 'package:flutter/material.dart';
import 'package:jemputah_app_driver/API/FetchData.dart';
import 'package:jemputah_app_driver/constants/color.dart';
import 'package:jemputah_app_driver/constants/icons.dart';
import 'package:jemputah_app_driver/constants/images.dart';
import 'package:jemputah_app_driver/constants/variable.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({super.key});

  @override
  State<TransaksiScreen> createState() => TransaksiScreenState();
}

class TransaksiScreenState extends State<TransaksiScreen> {
  List<Map<String, dynamic>> data = [];

  void setTransactionDriver() {
    var trasaction = FetchData().fetchListData("driver_transaction", uid);
    trasaction.then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setTransactionDriver();
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Scaffold(
          backgroundColor: AppColors.backgroundGreen,
          appBar: AppBar(
            leading: const BackButton(color: Colors.white),
            backgroundColor: AppColors.mainGreen,
            title: const Text('Transaksi'),
          ),
          body: Center(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 250, bottom: 50),
                child: Image.asset(
                  transaksiKosong,
                ),
              ),
              Text(
                "Ups, Anda belum melakukan \ntransaksi apapun",
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.hintTextColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )));
    }
    return Scaffold(
        backgroundColor: AppColors.backgroundGreen,
        appBar: AppBar(
          leading: const BackButton(color: Colors.white),
          backgroundColor: AppColors.mainGreen,
          title: const Text('Transaksi'),
        ),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                  color: AppColors.backgroundGreen,
                  child: ListTile(
                    //set title with style bold
                    title: const Text('Penukaran Koin Berhasil',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${(data[index]['koin_tukar'].toString())} Koin  |  Rp. ${data[index]['rupiah'].toString()}',
                          style: const TextStyle(color: Colors.black),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(data[index]['tgl_transaksi_driver']),
                        )
                      ],
                    ),
                    isThreeLine: true,
                    leading: Image.asset(
                      iconKoin,
                      width: 50,
                      height: 50,
                    ),
                  ));
            }));
  }
}
