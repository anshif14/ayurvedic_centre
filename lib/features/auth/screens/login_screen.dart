import 'package:ayurvedic_centre/core/common/imageConstants.dart';
import 'package:flutter/material.dart';



class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Image.asset(
                    ImageConstants.loginCover, // Replace with your logo path
                    height: 80,
                  ),
                ),
                SizedBox(height: 10),

                // Title
                Text(
                  "Login Or Register To Book Your Appointments",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),

                // Email TextField
                TextField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter your email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // Password TextField
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your login logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text("Login"),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Terms and Conditions & Privacy Policy
                Text(
                  "By creating or logging into an account you are agreeing with our ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Add Terms and Conditions page link
                      },
                      child: Text("Terms and Conditions"),
                    ),
                    Text(" and "),
                    TextButton(
                      onPressed: () {
                        // Add Privacy Policy page link
                      },
                      child: Text("Privacy Policy"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
