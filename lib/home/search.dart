import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/produkcard.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _searchKey = GlobalKey<FormState>();
  final _searchTextboxController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Form(
            key: _searchKey,
            child: TextField(
              controller: _searchTextboxController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            ),
          ),
        ),
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                image: AssetImage('assets/maaf.png'),
                height: 200,
                width: 200,
              ),
            ],
          ),
        )));
  }
}

class DataCari extends StatelessWidget {
  final String query;
  const DataCari({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: query.isEmpty
          ? FirebaseFirestore.instance.collection('product').snapshots()
          : FirebaseFirestore.instance
              .collection('product')
              .where('title', arrayContains: query)
              .snapshots(),
      builder: (context, snapshot) {
        return SingleChildScrollView(
          child: Center(
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
                  ))),
        );
      },
    );
  }
}
