import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project01/pages/RiwayatDetail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class RiwayatTransaksi extends StatelessWidget {
  const RiwayatTransaksi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Riwayat Transaksi',
          style: TextStyle(color: Colors.black),
        )),
        backgroundColor: Colors.white,
        elevation: 3,
        leading: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Image.asset(
            'assets/image/logo.png',
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushNamed('/maaf');
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('pesanan')
            .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return DaftarTransaksi(listTransaksi: snapshot.data!.docs);
        }),
      ),
    );
  }
}

class DaftarTransaksi extends StatefulWidget {
  final List<DocumentSnapshot> listTransaksi;
  const DaftarTransaksi({super.key, required this.listTransaksi});

  @override
  State<DaftarTransaksi> createState() => _DaftarTransaksiState();
}

class _DaftarTransaksiState extends State<DaftarTransaksi> {
  @override
  Widget build(BuildContext context) {
    if (widget.listTransaksi.isEmpty) {
      return const Center(
        child: Text('Tidak ada riwayat transaksi'),
      );
    }
    return ListView.builder(
        itemCount: widget.listTransaksi.length,
        itemBuilder: (context, i) => SingleChildScrollView(
              child: GestureDetector(
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.listTransaksi[i].id,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(widget.listTransaksi[i]['status'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.green))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: Text(
                                  widget.listTransaksi[i]['penerima'],
                                  style: const TextStyle(fontSize: 15),
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.listTransaksi[i]['tanggal'])
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(widget.listTransaksi[i]
                                              ['nama_barang']
                                          .toString()),
                                    ),
                                    Flexible(
                                      child: Text(
                                          "Rp ${NumberFormat('###,###,###,###', "ar_DZ").format(widget.listTransaksi[i]['harga_semua'])}"),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RiwayatDetail()));
                },
              ),
            ));
  }
}
