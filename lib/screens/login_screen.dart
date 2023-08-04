import 'package:firebase/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../components/ButtonWidget.dart';
import '../components/TextFieldWidget.dart';
import '../utils/toastMessages.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool visibility = false;
  bool isPress = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE8EBF5),
        appBar: AppBar(
          backgroundColor: const Color(0xffE8EBF5),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              "Welcome to Login",
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 0.5,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 29),
            child: Column(
              children: [
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(40),
                //   child: Container(
                //     margin: const EdgeInsets.only(top: 30),
                //     height: screenHeight * 0.31,
                //     decoration: const BoxDecoration(
                //       borderRadius:
                //       BorderRadius.only(topRight: Radius.circular(40)),
                //       image: DecorationImage(
                //         image: AssetImage("assets/images/G1.jpg"),
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: screenHeight * 0.02),
                TextFieldWidget(
                  controller: _emailController,
                  prefixIcon: Icons.email,
                  hintText: "Email",
                  labelText: "Email",
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFieldWidget(
                  controller: _passwordController,
                  prefixIcon: Icons.lock,
                  hintText: "Enter your Password",
                  labelText: "Password",
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        if (visibility) {
                          visibility = false;
                        } else {
                          visibility = true;
                        }
                      });
                    },
                    child: Icon(
                        visibility ? Icons.visibility : Icons.visibility_off,
                        color:
                            visibility ? Colors.black : Colors.grey.shade400),
                  ),
                  obscure: visibility,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        try {
                          await _auth.sendPasswordResetEmail(
                              email: _emailController.text.trim().toString());
                        } catch (e) {
                          print("Error $e");
                        }
                      },
                      child: const Text(
                        "Forget Password?",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                ButtonWidget(

                  backgroundColor: Colors.black,
                  buttonTitle: isPress? const CircularProgressIndicator(): const Text("Login"),
                  onPressed: () async {
                    setState(() {
                      isPress = true;
                    });
                    String email = _emailController.text.trim().toString();
                    String password =
                        _passwordController.text.trim().toString();
                    if (email.isNotEmpty && password.isNotEmpty) {
                      if (!isEmailValid(email)) {
                        setState(() {
                          isPress = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Invalid Email Format"),
                          ),
                        );
                        return;
                      }
                      if (!isPasswordValid(password)) {
                        setState(() {
                          isPress = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Password must be 8 cahraters long"),
                          ),
                        );
                        return;
                      }

                      try {
                        UserCredential userCredentials =
                            await _auth.signInWithEmailAndPassword(
                                email: _emailController.text.trim().toString(),
                                password:
                                    _passwordController.text.trim().toString());
                        User? user = userCredentials.user;
                        if (user != null) {
                          print("User Email :${user.email}");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        print("Message: $e");
                        setState(() {
                          isPress=false;
                        });
                        if(e is FirebaseAuthException && e.code=="wrong-password") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Wrong Password, Try Other"),
                            ),
                          );
                        }
                        if(e is FirebaseAuthException && e.code=="user-not-found") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("User not found, Please Register First"),
                            ),
                          );
                        }
                        else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Error, Something Wrong"),
                            ),
                          );
                        }

                      }
                    }
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignUp(),
                        ),
                      ),
                      child: const Text(
                        "SignUp?",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
