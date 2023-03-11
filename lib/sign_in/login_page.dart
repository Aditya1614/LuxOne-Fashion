import 'package:flutter/material.dart';

import '../Services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage([Key? key]) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/welcome_pict_4.png'),
                height: 200,
                width: 200,
              ),
              Container(
                  margin: const EdgeInsets.only(top: 20, right: 50, left: 50),
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () => AuthService().signInWithGoogle(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                              width: 50,
                              child: Image(
                                  width: 1,
                                  image: AssetImage('assets/google.png'))),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Masuk dengan google',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        )));
  }
}
