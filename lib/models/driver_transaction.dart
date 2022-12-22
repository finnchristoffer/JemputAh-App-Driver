import 'package:cloud_firestore/cloud_firestore.dart';

class DriverTransaction {
  Map<String, dynamic> snap(DocumentSnapshot snapshot) {
    var data = {
      "id_driver": snapshot['id_driver'],
      "koin_tukar": snapshot['koin_tukar'],
      "rupiah": snapshot['rupiah'],
      "tgl_transaksi_driver": snapshot['tgl_transaksi_driver'],
    };
    return data;
  }
}
