import 'package:firebase/components/ButtonWidget.dart';
import 'package:firebase/screens/otp_screen.dart';
import 'package:firebase/utils/toastMessages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({Key? key}) : super(key: key);

  @override
  _NumberScreenState createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  late bool isLoading = false;
  String verifyID = '';
  TextEditingController phoneController = TextEditingController();
  String countryDial = '+92';

  verifyPhone(String phoneNumber) async {
    setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) {
          setState(() {
            isLoading = false;
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            isLoading = false;
          });
          showSnackBar(e.message.toString(), context);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          showSnackBar('OTP has sent to your phone number', context);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) =>  OTPScreen(phoneNumber: phoneNumber,verifyID: verifyID,)));

          setState(() {
            verifyID = verificationId;
            isLoading = false;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE8EBF5),
        appBar: AppBar(
          backgroundColor: const Color(0xffE8EBF5),
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              "Number Verification",
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: IntlPhoneField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialValue: '+92',
                onChanged: (country) {
                  setState(() {
                    countryDial = country.countryCode;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: ButtonWidget(
                buttonTitle: isLoading ? const CircularProgressIndicator() : const Text("Send OTP"),
                onPressed: () {
                  verifyPhone(countryDial + phoneController.text.toString());
                },
                backgroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
