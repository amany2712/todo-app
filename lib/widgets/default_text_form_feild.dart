import 'package:flutter/material.dart';

class DefaultTextFormFeild extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  String? Function(String?)? validator;
  DefaultTextFormFeild({ required this.controller,required this.hintText,this.validator});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: validator,
    );
  }
}
