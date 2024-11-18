import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/tabs/settings/mode.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode themeModee = ThemeMode.light;
static String languageCode = 'en';



bool get isDark => themeModee == ThemeMode.dark;





void changeTheme (ThemeMode selectedTheme){
    themeModee = selectedTheme;
    
      saveTheme(selectedTheme);
      notifyListeners();

}

void changeLanguage (String selectedLanguage){
  if (selectedLanguage==languageCode) return; //So that the function does not repeat itself when I choose the same existing language
  languageCode = selectedLanguage;
  saveLanguage(selectedLanguage);
  notifyListeners();
}

//save theme

Future<void> saveTheme (ThemeMode themeMode) async {
  themeModee=themeMode;
 SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('theme', themeMode==ThemeMode.light?'light':'dark');
  notifyListeners();
}

//get theme

void getTheme() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String theme = prefs.getString('theme') ?? "light";

    themeModee=(theme =='light'?  ThemeMode.light: ThemeMode.dark);
    
   notifyListeners();
}

//save language 

void saveLanguage (String language) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (language == 'en'){
    prefs.setString('language', 'en');
  }else {
        prefs.setString('language', 'ar');
  }

}

//get language

void getLanguage ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String language = prefs.getString('language') ?? 'en';
    if (language == 'en'){
      languageCode= 'en';
    }else {
      languageCode = 'ar';
    }
    notifyListeners();
}

}