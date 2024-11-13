import 'package:ayurvedic_centre/features/auth/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/providers/authProvider.dart';

var height;
var width;

void main(){

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Splashscreen() ,
      ),
    );
  }
}
