import 'package:ayurvedic_centre/core/common/imageConstants.dart';
import 'package:ayurvedic_centre/features/auth/screens/login_screen.dart';
import 'package:ayurvedic_centre/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginScreen(),));
    },);

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: SizedBox(
    height: height,
    width: width,
    child: Image.asset(ImageConstants.splashBackground,fit: BoxFit.cover,)),
    );
  }
}
