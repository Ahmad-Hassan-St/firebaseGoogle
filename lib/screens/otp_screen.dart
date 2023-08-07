import 'package:firebase/screens/signup_screen.dart';
import 'package:firebase/utils/toastMessages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  final String verifyID;
  const OTPScreen({super.key, required this.verifyID, required this.phoneNumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  late bool isLoading = false;
  String otpPin = " ";
  Future<void> verifyOTP() async {
    bool verificationSuccessful = false;

    try {
      setState(() {
        isLoading = true;
      });

      await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: widget.verifyID,
          smsCode: otpPin,
        ),
      );


      verificationSuccessful = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        showSnackBar('Invalid OTP. Please enter a valid OTP.', context);
      }
    } finally {
      setState(() {
        isLoading = false;
      });

      if (verificationSuccessful) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SignUp(),
          ),
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color(0xffE8EBF5),

        appBar: AppBar(
        backgroundColor: const Color(0xffE8EBF5),
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "OTP Screen",
            style: TextStyle(
              color: Colors.black,
              letterSpacing: 1.1,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: PinCodeTextField(
                keyboardType: TextInputType.number,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  selectedFillColor: Colors.grey,
                  selectedColor: Colors.blueGrey,
                  inactiveFillColor: Colors.white,
                  inactiveColor: Colors.grey,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(15),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                controller: textEditingController,
                onChanged: (value) {
                  setState(() {
                    otpPin = value;
                  });
                },
                beforeTextPaste: (text) {
                  return true;
                },
                appContext: context,
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // Background color
                ),
                onPressed: () {
                  verifyOTP();
                },
                child: Text("Verify"),
              ),
            )
          ],
        ),
      ),
    );

  }
}