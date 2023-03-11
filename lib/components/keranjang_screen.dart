import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class KerajangScreen extends StatefulWidget {
  const KerajangScreen({super.key});

  @override
  State<KerajangScreen> createState() => _KerajangScreenState();
}

class _KerajangScreenState extends State<KerajangScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('keranjang')
            .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ItemBarang(listbarang: snapshot.data!.docs);
        }),
      ),
    );
  }
}

class ItemBarang extends StatelessWidget {
  final List<DocumentSnapshot> listbarang;

  const ItemBarang({super.key, required this.listbarang});

  @override
  Widget build(BuildContext context) {
    if (listbarang.isEmpty) {
      return const Center(
        child: Text('Keranjang anda kosong'),
      );
    }
    return ListView.builder(
        itemCount: listbarang.length,
        itemBuilder: (context, i) => SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              listbarang[i]['gambar'],
                              width: 50,
                            ),
                            Text(listbarang[i]['nama']),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  String id = listbarang[i].id;
                                  if (listbarang[i]['jumlah'] > 1) {
                                    FirebaseFirestore.instance
                                        .collection('keranjang')
                                        .doc(id)
                                        .update({
                                      'jumlah': listbarang[i]['jumlah'] - 1
                                    });
                                  } else {}
                                },
                                icon: SvgPicture.asset(
                                  "assets/icon/remove.svg",
                                )),
                            Text(listbarang[i]['jumlah'].toString()),
                            IconButton(
                                onPressed: () {
                                  String id = listbarang[i].id;
                                  if (listbarang[i]['jumlah'] < 99) {
                                    FirebaseFirestore.instance
                                        .collection('keranjang')
                                        .doc(id)
                                        .update({
                                      'jumlah': listbarang[i]['jumlah'] + 1
                                    });
                                  } else {}
                                },
                                icon: const Icon(Icons.add)),
                            IconButton(
                                onPressed: () {
                                  String id = listbarang[i].id;
                                  FirebaseFirestore.instance
                                      .collection('keranjang')
                                      .doc(id)
                                      .delete();
                                },
                                icon: SvgPicture.asset(
                                  "assets/icon/delete.svg",
                                ))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
