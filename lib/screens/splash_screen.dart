import 'package:firebase/screens/home_screen.dart';
import 'package:firebase/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsLogin();
  }

  void checkIsLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.get('email').toString();
    print(token);
   if( token != null && token.isNotEmpty){
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomeScreen()))
        ;}
   else {Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginScreen()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
