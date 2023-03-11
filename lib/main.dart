import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project01/pages/checkout.dart';
import 'package:project01/pages/detail_screen.dart';
import 'package:project01/pages/favorite.dart';
import 'package:project01/pages/infoakun.dart';
import 'package:project01/pages/lihat_semua.dart';
import 'package:project01/pages/maaf.dart';
import 'package:project01/components/splash_screen.dart';
import 'package:project01/pages/ubahemail.dart';

import 'Services/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        'home': (context) => AuthService().handleAuthState(),
        '/maaf': (context) => const Maaf(),
        '/checkout': (context) => const CheckOutPage(),
        '/favorite': (context) => const FavoriteScreen(),
        '/infoakun': (context) => const InfoAkun(),
        '/ubahemail': (context) => const UbahEmail(),
        '/lihatsemua': (context) => const LihatSemua(),
      },
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        if (settings.name == '/detailScreen') {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return DetailsScreen(
                index: args,
              );
            },
          );
        }
        return null;
      },
    );
  }
}
