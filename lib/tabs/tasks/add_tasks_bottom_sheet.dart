import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/settings/settings_provider.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:todo/widgets/default_elevated_bottom.dart';
import 'package:todo/widgets/default_text_form_feild.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AddTaskBottomSheet extends StatefulWidget {

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormate = DateFormat('dd/MM/yyyy');
  var formKey = GlobalKey <FormState>() ;

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    TextStyle ? titleMediumStyle = Theme.of(context).textTheme.titleMedium;        //We made this variable inside build because it has a context

    return Padding(
      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),  //viewInsets: Give him padding the size of the keyboard
      child: Container(
        height: MediaQuery.sizeOf(context).height*0.5,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(15),
            right:Radius.circular(15) 
           ),
          color: settingsProvider.isDark ? AppTheme.darkNavigation : AppTheme.white,
        ),
        
        
        child: Form(
          key: formKey ,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(AppLocalizations.of(context)!.addnewtask,
              style: titleMediumStyle,
              textAlign: TextAlign.center,
              ),
              SizedBox(height: 18,),
        
              DefaultTextFormFeild(
                controller: titleController,
                hintText: AppLocalizations.of(context)!.entertasktitle,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!.title_can_not_be_empty;
                   }
                 return null;
                  
                },
                ),
                SizedBox(height: 18,),
        
               DefaultTextFormFeild(
                controller:descriptionController ,
                hintText: AppLocalizations.of(context)!.entertaskdescription,
                validator: (value) {
                  if (value == null || value.trim().isEmpty ) {
                    return AppLocalizations.of(context)!.description_can_not_be_empty;
                   }
                 return null;
                  
                },
                ),
                 SizedBox(height: 18,),
                 Text(AppLocalizations.of(context)!.selectdate,
                 textAlign: TextAlign.center,
                 style: titleMediumStyle?.copyWith(fontSize: 20,fontWeight: FontWeight.w500 ),
                 ),
                 SizedBox(height: 8,),
        
                 InkWell(
                  onTap: () async {
                    DateTime? dateTime = await showDatePicker(
                     context: context, 
                     initialDate: selectedDate, 
                     firstDate: DateTime.now(),
                     lastDate: DateTime.now().add(Duration(days: 365)),
                     initialEntryMode: DatePickerEntryMode.calendarOnly
                     );
                    if (dateTime!=null && selectedDate != dateTime){
                      selectedDate = dateTime;
                    }
                     setState(() {});
        
                    } ,
                   child: Text( 
                    dateFormate.format(selectedDate)  ,
                   textAlign: TextAlign.center,style: titleMediumStyle),
                 ),
        
                 SizedBox(height: 35,),
        
                 //ElevatedButton
                 DefaultElevatedBottom(
                  label: AppLocalizations.of(context)!.add,
                  onPressed:(){
                    if (formKey.currentState!.validate()) {
                      addTask();
                      } 
    
    
                     }
                  ),
        
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTask () async {
    TaskModel task =TaskModel(
      title: titleController.text ,
      description: descriptionController.text ,
      date:selectedDate ,
     
      
    );
    String userId = Provider.of<UserProvider>(context,listen: false).CurrentUser!.id;

     await FirebaseFunctions.addTaskToFirestore(task,userId).then(
      
        (_) {
        Navigator.of(context).pop();
        Provider.of<TasksProvider>(context, listen: false).getTasks(userId);
         Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.taskaddedsuccessfully,
            toastLength: Toast.LENGTH_LONG,  //in android & IOS only
            timeInSecForIosWeb: 1,  //in web
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
           );
       },).catchError(
        (error)
        {
          //fluterToast
         Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.somethingwentwrong,
            toastLength: Toast.LENGTH_LONG,  //in android & IOS only
            timeInSecForIosWeb: 1,  //in web
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
           );
        } 
        );
  }
}