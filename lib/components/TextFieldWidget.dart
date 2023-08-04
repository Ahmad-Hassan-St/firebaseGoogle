import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  late TextEditingController controller = TextEditingController();
  late IconData prefixIcon;
  late bool? obscure;
  Widget? suffixIcon;
  late String labelText;
  late String hintText;
  //  Color? fillColor;
  //  bool? filled=false;

  TextFieldWidget({
  super.key,
  required this.controller,
  required this.prefixIcon,
  required this.hintText,
  required this.labelText,
  this.obscure = false,
  this.suffixIcon,
  //this.fillColor,
  //this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: Colors.black,
      ),
      controller: controller,
      obscureText: obscure ?? false,
      decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon,color: Colors.black,),
          suffixIcon: suffixIcon,
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(

            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),

          filled: true,
          fillColor:Colors.white


      ),
    );
  }
}




class TextFormFieldWidget extends StatelessWidget {
  late TextEditingController controller = TextEditingController();
  late IconData prefixIcon;
  late bool? obscure;
  Widget? suffixIcon;
  late String labelText;
  late String hintText;
  final String? Function(String?)? validator; // Accepts custom validator function

  //  Color? fillColor;
  //  bool? filled=false;

  TextFormFieldWidget({
  super.key,
  required this.controller,
  required this.prefixIcon,
  required this.hintText,
  required this.labelText,
  this.obscure = false,
  this.suffixIcon,
  required this.validator,
  //this.fillColor,
  //this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black,
      ),
      controller: controller,
      obscureText: obscure ?? false,
      decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon,color: Colors.black,),
          suffixIcon: suffixIcon,
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(

            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),

          filled: true,
          fillColor:Colors.white


      ),
      validator:validator,
    );
  }
}
