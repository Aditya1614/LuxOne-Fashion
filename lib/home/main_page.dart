import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project01/home/riwayat_transaksi.dart';
import 'package:project01/home/cart.dart';
import 'package:project01/home/home.dart';
import 'package:project01/home/profile.dart';
import 'package:project01/home/search.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.grey,
        backgroundColor: Colors.transparent,
        height: 53,
        index: index,
        items: <Widget>[
          const Icon(Icons.home, color: Colors.white),
          const Icon(Icons.search, color: Colors.white),
          const Icon(Icons.shopping_cart, color: Colors.white),
          SvgPicture.asset(
            "assets/icon/receipt.svg",
            color: Colors.white,
            width: 28,
          ),
          const Icon(Icons.account_circle, color: Colors.white),
        ],
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
      ),
      body: Container(
        child: getSelectedWidget(index: index),
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const Home();
        break;
      case 1:
        widget = const Search();
        break;
      case 2:
        widget = const Cart();
        break;
      case 3:
        widget = const RiwayatTransaksi();
        break;
      case 4:
        widget = const Profile();
        break;
      default:
        widget = const Home();
        break;
    }
    return widget;
  }
}
