import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Services/auth_services.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Profil Ku',
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
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(user.photoURL!),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                ),
                Flexible(
                    child: Text(
                  FirebaseAuth.instance.currentUser!.displayName ?? '',
                  style: const TextStyle(fontSize: 25),
                ))
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed('/maaf');
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.redAccent,
                              size: 25,
                            ),
                          ),
                        ),
                        const Text('Favorit',
                            style:
                                TextStyle(fontSize: 25, color: Colors.black87)),
                      ],
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed('/infoakun');
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: const Icon(
                              Icons.info,
                              color: Colors.black87,
                              size: 25,
                            ),
                          ),
                        ),
                        const Text('Info Akun',
                            style:
                                TextStyle(fontSize: 25, color: Colors.black87)),
                      ],
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed('/maaf');
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: const Icon(
                              Icons.settings,
                              color: Colors.black87,
                              size: 25,
                            ),
                          ),
                        ),
                        const Text('Pengaturan',
                            style:
                                TextStyle(fontSize: 25, color: Colors.black87)),
                      ],
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                    onPressed: () async {
                      await GoogleSignIn().disconnect();
                      await AuthService().signOut();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: const Icon(
                              Icons.logout,
                              color: Colors.black87,
                              size: 25,
                            ),
                          ),
                        ),
                        const Text('Keluar akun',
                            style:
                                TextStyle(fontSize: 25, color: Colors.black87)),
                      ],
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
