import 'package:flutter/material.dart';
import 'package:project01/Services/auth_services.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>{
  late VideoPlayerController _controller;

  @override
  void initState(){
    super.initState();

    _controller = VideoPlayerController.asset(
      'assets/logo_LO.mp4',
    )
      ..initialize().then((_) {
        setState(() {});
      })
      ..setVolume(0.0);

    _playVideo();
  }

  void _playVideo() async {
    _controller.play();

    await Future.delayed(const Duration(seconds: 5));

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> AuthService().handleAuthState()));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(
            _controller,
          ),
        )
            : Container(),
      ),
    );
  }
}