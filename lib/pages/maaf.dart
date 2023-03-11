import 'package:flutter/material.dart';

class Maaf extends StatelessWidget {
  const Maaf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Maaf'),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.grey,
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
