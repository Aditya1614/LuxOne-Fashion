import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Favorit',
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
            .collection('favorite')
            .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ItemFavorite(listfavorit: snapshot.data!.docs);
        }),
      ),
    );
  }
}

class ItemFavorite extends StatelessWidget {
  final List<DocumentSnapshot> listfavorit;

  const ItemFavorite({super.key, required this.listfavorit});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listfavorit.length,
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
                              listfavorit[i]['gambar'],
                              width: 50,
                            ),
                            Text(listfavorit[i]['nama']),
                          ],
                        ),
                        Row(children: [Text(listfavorit[i]['price'].toString()),]),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
