import 'package:ayurvedic_centre/core/common/TopSnackBarWidget.dart';
import 'package:ayurvedic_centre/core/common/color_palette.dart';
import 'package:ayurvedic_centre/core/common/imageConstants.dart';
import 'package:ayurvedic_centre/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../home/screens/home_screen.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController  =TextEditingController();
  TextEditingController _passwordController  =TextEditingController();
  void _login() async {

    if(_usernameController.text ==''){
      topSnackBarWidget().topSnackBarError(context, "Please enter Username");
      return;
    } if(_passwordController.text ==''){
      topSnackBarWidget().topSnackBarError(context, "Please enter Password");
      return;
    }

    final provider = Provider.of<LoginProvider>(context, listen: false);

    try {
      await provider.login(
        context,
        _usernameController.text,
        _passwordController.text,
      );
      if (provider.token != null) {

        print(provider.token);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${error.toString()}')),
      );
    }
  }
  @override
  void initState() {

    if(kDebugMode){
      _usernameController.text = 'test_user';
      _passwordController.text = '12345678';
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImageConstants.loginCover),
                      fit: BoxFit.cover)),
              height: height * 0.3,
              width: width,
              margin: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: Image.asset(
                  ImageConstants.logo,
                  height: height * 0.1, // Replace with your logo path
                  // fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),

            // Title
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    "Login Or Register To Book Your Appointments",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Email TextField

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Username",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: ColorPalette.textBlackOne),
                      ),
                    ),
                  ),

                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.8, color: Color(0x1a000000)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.8, color: Color(0x1a000000)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.8, color: Color(0x1a000000)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: ColorPalette.textFieldBackground,
                      filled: true,
                      // labelText: "Email",
                      hintText: "Enter your username",
                      hintStyle: GoogleFonts.inter(fontWeight: FontWeight.w300),

                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.8, color: Color(0x1a000000)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Password TextField
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Password",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: ColorPalette.textBlackOne),
                      ),
                    ),
                  ),

                  Column(
                    children: [
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          // labelText: "Password",
                          hintText: "Enter password",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.8, color: Color(0x1a000000)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.8, color: Color(0x1a000000)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.8, color: Color(0x1a000000)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: ColorPalette.textFieldBackground,
                          filled: true,
                          hintStyle:
                              GoogleFonts.inter(fontWeight: FontWeight.w300),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _login();
                        // Add your login logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorPalette.primaryColor, // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.15),

                  // Terms and Conditions & Privacy Policy
                  // Text(
                  //   "By creating or logging into an account you are agreeing with our ",
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(fontSize: 12),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     TextButton(
                  //       onPressed: () {
                  //         // Add Terms and Conditions page link
                  //       },
                  //       child: Text("Terms and Conditions"),
                  //     ),
                  //     Text(" and "),
                  //     TextButton(
                  //       onPressed: () {
                  //         // Add Privacy Policy page link
                  //       },
                  //       child: Text("Privacy Policy"),
                  //     ),
                  //   ],
                  // ),

                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text:
                              "By creating or logging into an account you are agreeing with our ",
                          // a: TextAlign.center,

                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                        ),
                        TextSpan(
                          text: " Terms and Conditions ",
                          // a: TextAlign.center,

                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.indigo,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: " and ",
                          // a: TextAlign.center,

                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                        ),
                        TextSpan(
                          text: " Privacy Policy.",
                          // a: TextAlign.center,

                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.indigo,
                              fontWeight: FontWeight.w500),
                        ),
                      ]))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
