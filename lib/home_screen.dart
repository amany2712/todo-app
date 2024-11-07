import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/tabs/settings/settings_tab.dart';
import 'package:todo/tabs/tasks/tasks_tab.dart';

class HomeScreen extends StatefulWidget {

  static const String routeHome = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List <Widget> tabs =[
    TasksTab(),SettingsTab()
  ];
  int currentTabIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentTabIndex],

      //bottom app bar material3

      bottomNavigationBar:BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: AppTheme.white,  
        padding: EdgeInsets.zero,        
        //BottomNavigationBar 
        child: BottomNavigationBar(
          currentIndex: currentTabIndex,
          onTap: (index) =>setState(() => currentTabIndex = index) ,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              label: 'Tasks',
              icon:Icon(Icons.list )
              ),
      
              BottomNavigationBarItem(
                label: 'Settings',
              icon:Icon(Icons.settings ) 
              ),
          ]),
      ) ,

        //floatingActionButton

        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: Icon(Icons.add,
          size: 32,
          ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,



    );
  }
}