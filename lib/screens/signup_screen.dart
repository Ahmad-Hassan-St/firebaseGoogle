import 'package:firebase/components/ButtonWidget.dart';
import 'package:firebase/components/SocailLogin.dart';
import 'package:firebase/services/AuthServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/TextFieldWidget.dart';
import '../utils/toastMessages.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  bool visibility = true;
  bool isPress = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE8EBF5),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xffE8EBF5),
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              "SignUp",
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 1.1,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormFieldWidget(
                    controller: _emailController,
                    prefixIcon: Icons.email,
                    hintText: "Email",
                    labelText: "Email",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      } else if (!isEmailValid(value)) {
                        return 'Invalid Email Format';
                      }
                      return null; // Return null if the input is valid
                    },
                  ),

                  const SizedBox(height: 20),
                  TextFormFieldWidget(
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      } else if (!isPasswordValid(value)) {
                        return 'Password must contain at least 8 characters\nnone uppercase letter\none lowercase letter\none numeric digit\none special symbol';
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                  const SizedBox(height: 20),
                  ButtonWidget(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          UserCredential user =
                          await _auth.createUserWithEmailAndPassword(
                            email: _emailController.text.trim().toString(),
                            password:
                            _passwordController.text.trim().toString(),
                          );
                          if (user != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'email-already-in-use') {
                            showSnackBar(
                                'Try another Email, It\'s already in use',
                                context);
                          } else {
                            showSnackBar("Error : ${e.code}", context);
                          }
                        }
                      }
                    },
                    buttonTitle: const Text("Register"),
                    backgroundColor: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            ),
                        child: const Text(
                          "Login?",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialLogin(
                          imagePath: "assets/images/google.png",
                          onTap: () async {
                            UserCredential userCredential = await AuthServices().signInWithGoogle();
                            User? user = userCredential.user; // Extract the User object from UserCredential
                            if(user !=null){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()),);
                        }
                      }),
                      SizedBox(width: 40,),
                      SocialLogin(
                          imagePath: "assets/images/fb.png", onTap: () {})

                    ],
                  ),

                  // _auth.signInWithEmailAndPassword(email: email, password: password)
                  //
                  // _auth.sendPasswordResetEmail(email: email)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
