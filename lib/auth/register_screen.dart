import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/widgets/default_elevated_bottom.dart';
import 'package:todo/widgets/default_text_form_feild.dart';

class RegisterScreen extends StatefulWidget {
static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Register',
                style: Theme.of(context).textTheme.titleMedium ?.copyWith(
                  color: AppTheme.black,
                  fontSize: 22,
                ),textAlign: TextAlign.center),
              centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextFormFeild(
                controller: nameController,
                 hintText: 'Name',
                 validator: (value) {
                  if (value==null || value.trim().length <3){
                    return "Name can not be less than 5 characters";
                  }
                  return null;
                 } ,
                 ),
                 SizedBox(height: 18,),
              DefaultTextFormFeild(
                controller: emailController,
                 hintText: 'Email',
                 validator: (value) {
                  if (value==null || value.trim().length <5){
                    return "Email can not be less than 5 characters";
                  }
                  return null;
                 } ,
                 ),
                 SizedBox(height: 18,),
              
                 DefaultTextFormFeild(
                controller: passwordController,
                 hintText: 'Password',
                 validator: (value) {
                  if (value==null || value.trim().length <8){
                    return "Password can not be less than 8 characters";
                  }
                  return null;
                 } ,
                 isPassword: true,
                 ),
                 SizedBox(height: 40,),
              
                 DefaultElevatedBottom(
                  label: 'Register',
                   onPressed: register
                   ),
                   SizedBox(height: 8,),
                    TextButton(
                    onPressed: () =>
                    Navigator.of(context).pushReplacementNamed(
                      LoginScreen.routeName
                      ),
                     child: Text('Already have an account')
                     ),
            ],
          ),
        ),
      ),
    );
  }
  void register (){
    if (formKey.currentState!.validate()){
      //register
    }
  }
}
