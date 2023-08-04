import 'package:flutter/material.dart';

class SocialLogin extends StatelessWidget {
  final String imagePath;
  VoidCallback onTap;
   SocialLogin({
    Key? key,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Image.asset(imagePath,height: 40,),
      ),
    );
  }
}
