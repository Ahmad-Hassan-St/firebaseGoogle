import 'package:firebase/screens/login_screen.dart';
import 'package:firebase/screens/number_screen.dart';
import 'package:firebase/screens/signup_screen.dart';
import 'package:firebase/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const FirebaseConnectivity());
}

class FirebaseConnectivity extends StatefulWidget {
  const FirebaseConnectivity({Key? key}) : super(key: key);

  @override
  _FirebaseConnectivityState createState() => _FirebaseConnectivityState();
}

class _FirebaseConnectivityState extends State<FirebaseConnectivity> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
