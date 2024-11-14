import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/auth/register_screen.dart';
import 'package:todo/home_screen.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/edit_screen.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();  //Internet cut off on firestore only ,, local
  runApp (
    ChangeNotifierProvider(
      create: (_) => TasksProvider(),
      child: TodoApp()));
}

class TodoApp extends StatelessWidget {
  late TaskModel task ;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeHome : (_) => HomeScreen(),
        EditScreen.routeName :(context) => EditScreen(task),
        LoginScreen.routeName : (_) => LoginScreen(),
        RegisterScreen.routeName : (_) => RegisterScreen(),
      },
      initialRoute: HomeScreen.routeHome ,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,



    );
  }
}