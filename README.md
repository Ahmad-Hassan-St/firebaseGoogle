# firebase

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

In this repository All source code regarding Firebase connectivity and sign-in/signUp with GOOGLE:
lib/services/authServices.dart 
this file contains the source code of the GOOGLEAuth function:
here are simple steps to integrate with this function:
- create a Firebase project
- authentication allow with GOOGLE
- Run commands on your project terminal to connect with Firebase `flutterfire configure`
- Change your project directory `cd android`
- Run this command `gradlew signingReport` or `./gradlew signingReport`
- Wait for the compilation to finish and your SHA keys (SHA-1 and SHA-256) should be printed out for you
- Use these keys to authenticate your app in https://console.firebase.google.com/ or in your project **ADD KEY** option
- Download and replace the google-services.json in your Android folder if commands did not download for you
- Run command `flutter clean` and `flutter build`
Here is the Source code :
`function`

signInWithGoogle() async {

    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credentials = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credentials);
  }

The function `calling` and You can also use your own logic

onTap: () async {

     UserCredential userCredential = await AuthServices().signInWithGoogle();
     
     User? user = userCredential.user; // Extract the User object from UserCredential
       if (user != null) {
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => HomeScreen()),                              );
   },
 }
