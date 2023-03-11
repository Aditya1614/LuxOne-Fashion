import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.index}) : super(key: key);

  final index;
  static const routeName = '/detailScreen';

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference keranjang = firestore.collection('keranjang');

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('product').snapshots(),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          backgroundColor: const Color(0xFFEFEFF2),
          appBar: AppBar(
            leading: const BackButton(color: Colors.black),
            backgroundColor: const Color(0xFFEFEFF2),
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  Fluttertoast.showToast(
                    msg: "Fitur ini masih dalam tahap pengembangan",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                  );
                },
                icon: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: SvgPicture.asset(
                    "assets/icon/Heart.svg",
                    height: 20,
                  ),
                ),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                  snapshot.data!.docs[index]['image'],
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.cover,
                ),
              ),
              // const SizedBox(height: 24),
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(top: 24),
                  padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              snapshot.data!.docs[index]['title'],
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "Rp ${NumberFormat('###,###,###,###', "ar_DZ").format(snapshot.data!.docs[index]['price'])}",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          snapshot.data!.docs[index]['desc'],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            label: const Text("Tambah ke keranjang"),
            backgroundColor: Colors.pinkAccent,
            onPressed: () async {
              final data = await keranjang
                  .where('UID',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .where('id', isEqualTo: snapshot.data!.docs[index]['id'])
                  .get();

              if (data.docs.isNotEmpty) {
                String id = data.docs[0].id;
                keranjang
                    .doc(id)
                    .update({'jumlah': data.docs[0]['jumlah'] + 1});
              } else {
                keranjang.add({
                  'gambar': snapshot.data!.docs[index]['image'],
                  'nama': snapshot.data!.docs[index]['title'],
                  'deskripsi': snapshot.data!.docs[index]['desc'],
                  'price': snapshot.data!.docs[index]['price'],
                  'id': snapshot.data!.docs[index]['id'],
                  'jumlah': 1,
                  'UID': FirebaseAuth.instance.currentUser!.uid
                });
              }
              Fluttertoast.showToast(
                  msg: "Ditambahkan ke keranjang",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
          ),
        );
      }),
    );
  }
}
