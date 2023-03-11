import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project01/components/produkcard.dart';

class LihatSemua extends StatelessWidget {
  const LihatSemua({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'Gaun',
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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('product').snapshots(),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Center(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(
                          snapshot.data!.docs.length,
                          (index) => ProductCard(
                            title: snapshot.data!.docs[index]['title'],
                            image: snapshot.data!.docs[index]['image'],
                            price: snapshot.data!.docs[index]['price'],
                            bgColor: const Color(0xFFEFEFF2),
                            press: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed('/detailScreen', arguments: index);
                            },
                          ),
                        ),
                      )));
            }),
          ),
        ));
  }
}
