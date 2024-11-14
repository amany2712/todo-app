import 'package:flutter/material.dart';

class DefaultTextFormFeild extends StatefulWidget {
  TextEditingController controller;
  String hintText;
  String? Function(String?)? validator;
  bool isPassword;
  DefaultTextFormFeild({ required this.controller,required this.hintText,this.validator,this.isPassword=false});

  @override
  State<DefaultTextFormFeild> createState() => _DefaultTextFormFeildState();
}

class _DefaultTextFormFeildState extends State<DefaultTextFormFeild> {
 late bool isObscur = widget.isPassword ;  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon:widget.isPassword ? IconButton(
          onPressed: (){
            isObscur =!isObscur;
            setState(() {});
          },
           icon: Icon(
             isObscur 
               ? Icons.visibility_outlined 
               : Icons.visibility_off_outlined
            )
           )
           :null,
      ),
      validator: widget.validator,
      obscureText:isObscur ,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
