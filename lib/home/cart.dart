import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project01/Services/argument.dart';
import 'package:project01/components/keranjang_screen.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Keranjang Ku',
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
      body: const KerajangScreen(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final dataKeranjang = await FirebaseFirestore.instance
              .collection('keranjang')
              .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get();

          if (dataKeranjang.docs.isNotEmpty) {
            int total = 0;
            for (int i = 0; i < dataKeranjang.docs.length; i++) {
              total = (dataKeranjang.docs[i]['jumlah'] *
                      dataKeranjang.docs[i]['price']) +
                  total;
            }
            Navigator.pushNamed(context, '/checkout',
                arguments: Arguments(total));
          } else {
            Fluttertoast.showToast(
                msg: "Keranjang anda kosong",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        label: Row(
          children: [
            const Text('CheckOut'),
            SvgPicture.asset(
              'assets/icon/arrow.svg',
              width: 30,
              color: Colors.white,
            ),
          ],
        ),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
