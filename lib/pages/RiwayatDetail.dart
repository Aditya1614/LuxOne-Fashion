import 'package:flutter/material.dart';

class RiwayatDetail extends StatelessWidget {
  const RiwayatDetail([Key? key]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kembali'),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.grey,
        ),
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                image: AssetImage('assets/wa_sms2.png'),
                height: 200,
                width: 200,
              ),
            ],
          ),
        )));
  }
}
