import 'package:ayurvedic_centre/features/auth/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'core/providers/authProvider.dart';
import 'core/providers/patient_provider.dart';
import 'features/auth/controller/auth_controller.dart';
import 'features/home/screens/home_screen.dart';

var height;
var width;
String? currentUserToken;

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
        ChangeNotifierProvider(create: (_) => PatientProvider()),
      ],
      child:  GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: MaterialApp(
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme()
          ),
          debugShowCheckedModeBanner: false,
          home:Splashscreen() ,
        ),
      ),
    );
  }
}
