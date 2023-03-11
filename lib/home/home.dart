import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:project01/components/bannerlist.dart';
import 'package:project01/produk/shirt.dart';

import '../components/offline_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'LuxOne Fashion',
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
          child: StreamBuilder(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
              return snapshot.data == ConnectivityResult.mobile ||
                      snapshot.data == ConnectivityResult.wifi
                  ? Column(
                      children: const [BannerList(), Shirt()],
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: const Offline(),
                    );
            },
          ),
        ),
      ),
    );
  }
}
