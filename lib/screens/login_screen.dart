import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth/screens/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100, // Set background color
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView( // Add SingleChildScrollView to allow scrolling
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // Align items to center
            children: [
              SizedBox(height: 100), // Add some space at the top
              Text(
                "Phone Authentication",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900), // Add color to the title
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: "Enter Phone Number",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              isloading
                  ? CircularProgressIndicator(
                color: Colors.blue.shade900, // Set indicator color
              )
                  : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900, // Set button color
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    isloading = true;
                  });

                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: phoneController.text,
                    verificationCompleted: (phoneAuthCredential) {},
                    verificationFailed: (error) {
                      log(error.toString());
                    },
                    codeSent: (verificationId, forceResendingToken) {
                      setState(() {
                        isloading = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OTPScreen(
                                verificationId: verificationId,
                              )));
                    },
                    codeAutoRetrievalTimeout: (verificationId) {
                      log("Auto Retireval timeout");
                    },
                  );
                },
                child: Text(
                  "Sign in",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 30), // Add some space at the bottom
            ],
          ),
        ),
      ),
    );
  }
}