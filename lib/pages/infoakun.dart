import 'package:flutter/material.dart';

class InfoAkun extends StatelessWidget {
  const InfoAkun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Akun'),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed('/ubahemail');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Icon(
                      Icons.ad_units,
                      color: Colors.black87,
                      size: 25,
                    ),
                  ),
                ),
                const Text('Ubah email',
                    style: TextStyle(fontSize: 25, color: Colors.black87)),
              ],
            )),
      ),
    );
  }
}
