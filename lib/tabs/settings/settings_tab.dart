import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/tabs/settings/language.dart';
import 'package:todo/tabs/settings/mode.dart';
import 'package:todo/tabs/settings/settings_provider.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class SettingsTab extends StatefulWidget {

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
   List <Language> languages =[
     Language(name: "English", code: "en"),
     Language(name: "العربية", code: "ar")
    ];
    List <Mode> modes =[
     Mode(name: "Light", thememode: ThemeMode.light),
     Mode(name: "Dark",thememode: ThemeMode.dark)
    ];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(

      appBar:  AppBar(
        titleSpacing: screenHeight*.04,
        elevation: 0,
        backgroundColor: AppTheme.primary,
        title: Text(AppLocalizations.of(context)!.settings,
                style: Theme.of(context).textTheme.titleMedium ?.copyWith(
                  color: AppTheme.white,
                  fontSize: 22,
                ),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppTheme.primary,
            height: screenHeight*0.08,
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: 
              
                Text(AppLocalizations.of(context)!.language,
                  style:Theme.of(context).textTheme.titleSmall ?.copyWith(fontWeight: FontWeight.bold) ,
                 ),
           ),
          SizedBox(height: 20,),

                Container(
                   width: double.infinity, 
                    height: 45 , 
                  margin:EdgeInsets.symmetric(horizontal: screenHeight*.05),
                  decoration: BoxDecoration(
                     border: Border.all( 
                       color: AppTheme.primary,     
                     ),
                     color: settingsProvider.isDark ? AppTheme.darkNavigation : AppTheme.white,
                   
                    ),
                  child: DropdownButtonHideUnderline(
                    
                    child: DropdownButton<Language>(
                          value:languages.firstWhere((Language) => Language.code==SettingsProvider.languageCode),
                          items:languages.map((Language) => DropdownMenuItem(
                          value: Language,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                               Language.name,
                               style: Theme.of(context).textTheme.headlineLarge ?.copyWith(
                                 color: settingsProvider.isDark ? AppTheme.primary : AppTheme.darkNavigation,
                                 fontSize: 14,
                                 ),
                               ),
                          )
                           )
                           ).toList(),
                        onChanged: (selectedLanguage){
                          if (selectedLanguage!=null){
                           settingsProvider.changeLanguage(selectedLanguage.code);
                            }


                        },
                        icon: Icon(Icons.arrow_drop_down, color: AppTheme.primary), // Arrow icon
                         iconSize: 33, // Size of the arrow
                         alignment: Alignment.topRight, // Align the content
                         borderRadius:  BorderRadius.circular(18),
                         
                    
                    
                    
                    
                    
                    
                    
                        
                        ),
                    
                    
                ),
                ),
                //mode

                SizedBox(height: 22,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20),
               child: 
                Text(AppLocalizations.of(context)!.mode,
                 style:Theme.of(context).textTheme.titleSmall ?.copyWith(fontWeight: FontWeight.bold) ,
                 ),
               ),
               SizedBox(height: 20,),

               Container(
                   width: double.infinity, 
                    height: 45 , 
                  margin:EdgeInsets.symmetric(horizontal: screenHeight*.05),
                  decoration: BoxDecoration(
                     border: Border.all( 
                       color: AppTheme.primary,     
                     ),
                     color: settingsProvider.isDark ? AppTheme.darkNavigation : AppTheme.white,
                   
                    ),
                  child: DropdownButtonHideUnderline(
                    
                    child: DropdownButton<Mode>(
                          value:modes.firstWhere((Mode) => Mode.thememode==settingsProvider.themeModee),
                          items:modes.map((Mode) => DropdownMenuItem(
                          value: Mode,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                               Mode.name,
                               style: Theme.of(context).textTheme.headlineLarge ?.copyWith(
                                 color: settingsProvider.isDark ? AppTheme.primary : AppTheme.darkNavigation,
                                 fontSize: 14,
                                 ),
                               ),
                          )
                           )
                           ).toList(),
                        onChanged:(selectedMode) {
                           if (selectedMode != null) {
                              
                            settingsProvider.saveTheme(selectedMode.thememode);
                          }

                                 },
                                 
                        icon: Icon(Icons.arrow_drop_down, color: AppTheme.primary), // Arrow icon
                         iconSize: 33, // Size of the arrow
                         alignment: Alignment.topRight, // Align the content
                         borderRadius:  BorderRadius.circular(18),
                         
                    
                    
                    
                    
                    
                    
                    
                        
                        ),
                    
                    
                ),
                ),

                 //Switch(
                 //value: settingsProvider.themeModee == ThemeMode.dark,  //The value that will be displayed  .. =>true/false
                 //onChanged:(isDark) =>settingsProvider.saveTheme(isDark ? ThemeMode.dark : ThemeMode.light),   //isDark ==Value
                 //activeTrackColor: AppTheme.black,
                  
                 
                 //),
                SizedBox(height: 40,),
            
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.logout,
                      style: Theme.of(context).textTheme.titleMedium,),
                      Container(
                        decoration: BoxDecoration(
                         color: AppTheme.primary,
                          shape: BoxShape.circle, // Circular shape
                         boxShadow: [
                             BoxShadow(
                             color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                             ),
                           ],
                         ),
                        child: IconButton(color: AppTheme.white,
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                            Provider.of<TasksProvider>(context,listen: false).tasks.clear();
                            Provider.of<UserProvider>(context,listen: false).updateUser(null);
                            
                            
                          },
                           icon: Icon(
                            Icons.logout,
                            size: 30,
                            ),
                           ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}