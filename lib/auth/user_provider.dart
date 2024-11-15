import 'package:flutter/material.dart';
import 'package:todo/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel ? CurrentUser;

  void updateUser (UserModel? user){
    CurrentUser = user;
    notifyListeners();

  }
}