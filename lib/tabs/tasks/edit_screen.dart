import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:todo/widgets/default_elevated_bottom.dart';
import 'package:todo/widgets/default_text_form_feild.dart';

class EditScreen extends StatefulWidget {
 static const String routeName='/edit-centent';
  TaskModel task; // Pass the task to be edited

  EditScreen( this.task);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Initialize the controllers with the current task's values
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
    selectedDate = widget.task.date;
  }

  @override
  //that uses listeners to track state changes.
  void dispose() {
    // Dispose controllers when widget is removed from the widget tree
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        double screenHeight = MediaQuery.sizeOf(context).height;
            TextStyle ? titleMediumStyle = Theme.of(context).textTheme.titleMedium;        //We made this variable inside build because it has a context
        

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.primary,
        title: Text('To Do List',
                style: Theme.of(context).textTheme.titleMedium ?.copyWith(
                  color: AppTheme.white,
                  fontSize: 22,
                ),),
      ),
      body: Stack(
        children: [
          Container(
            color: AppTheme.primary,
            height: screenHeight*0.08,
            

          ),
          Container(
            height: MediaQuery.sizeOf(context).height*0.77,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(15),
                right:Radius.circular(15) 
               ),
              color: AppTheme.white,
            ),
            
            
            child: Form(
              key: formKey ,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Edit Task',
                  style: titleMediumStyle,
                  textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50,),
            
                  DefaultTextFormFeild(
                    controller: titleController,
                    hintText: 'This is title',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return ' Title can not be empty ';
                       }
                     return null;
                      
                    },
                    ),
                    SizedBox(height: 35,),
            
                   DefaultTextFormFeild(
                    controller:descriptionController ,
                    hintText: 'Task details ',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty ) {
                        return ' task details can not be empty ';
                       }
                     return null;
                      
                    },
                    ),
                     SizedBox(height: 45,),
                     Text('Select date',
                     textAlign: TextAlign.center,
                     style: titleMediumStyle?.copyWith(fontSize: 20,fontWeight: FontWeight.w500 ),
                     ),
                     SizedBox(height: 12,),
            
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
                        dateFormat.format(selectedDate)  ,
                       textAlign: TextAlign.center,),
                     ),
            
                     SizedBox(height: 100,),
            
                     //ElevatedButton
                     DefaultElevatedBottom(
                      label: 'Save Changes',
                      onPressed:(){
                        if (formKey.currentState!.validate()) {
                          editTask();
                          } }
                     )
            
            
                         
                      
            
                ],
              ),
            ),
          ),
        ],
      ),
      
        
    );
  }

  Future <void> editTask () async {
    TaskModel updateTaske =TaskModel(
      id:widget.task.id,
      title: titleController.text ,
      description: descriptionController.text ,
      date:selectedDate ,
      
    );
    String userId = Provider.of<UserProvider>(context,listen: false).CurrentUser!.id;
    FirebaseFunctions.updateTaskInFirestore(updateTaske,userId)
    .timeout(
      Duration(microseconds: 100),
       onTimeout: () {
        Navigator.of(context).pop();
        Provider.of<TasksProvider>(context, listen: false).getTasks(userId);
         Fluttertoast.showToast(
            msg: "Task update successfully",
            toastLength: Toast.LENGTH_LONG,  //in android & IOS only
            timeInSecForIosWeb: 1,  //in web
            backgroundColor: AppTheme.green,
            textColor: AppTheme.white,
            fontSize: 16.0
           );
       },
    )
    .catchError((error) {
      //fluterToast
         Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_LONG,  //in android & IOS only
            timeInSecForIosWeb: 1,  //in web
            backgroundColor: AppTheme.red,
            textColor: AppTheme.white,
            fontSize: 16.0
           );
    });
     
  }
}