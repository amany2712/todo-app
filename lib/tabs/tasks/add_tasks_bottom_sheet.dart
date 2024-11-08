import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/widgets/default_elevated_bottom.dart';
import 'package:todo/widgets/default_text_form_feild.dart';

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

    TextStyle ? titleMediumStyle = Theme.of(context).textTheme.titleMedium;        //We made this variable inside build because it has a context

    return Container(
      height: MediaQuery.sizeOf(context).height*0.5,
      padding: EdgeInsets.all(20),
      
      
      child: Form(
        key: formKey ,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Add new Task',
            style: titleMediumStyle,
            textAlign: TextAlign.center,
            ),
            SizedBox(height: 18,),
      
            DefaultTextFormFeild(
              controller: titleController,
              hintText: 'Enter task title',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return ' Title can not be empty ';
                 }
               return null;
                
              },
              ),
              SizedBox(height: 18,),
      
             DefaultTextFormFeild(
              controller:descriptionController ,
              hintText: 'Enter task discription ',
              validator: (value) {
                if (value == null || value.trim().isEmpty ) {
                  return ' Description can not be empty ';
                 }
               return null;
                
              },
              ),
               SizedBox(height: 18,),
               Text('Select date',
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
                  if (dateTime!=null){
                    selectedDate = dateTime;
                  }
                   setState(() {});
      
                  } ,
                 child: Text(
                  dateFormate.format(selectedDate)  ,
                 textAlign: TextAlign.center,),
               ),
      
               SizedBox(height: 35,),
      
               //ElevatedButton
               DefaultElevatedBottom(
                label: 'Add',
                onPressed:(){
                  if (formKey.currentState!.validate()) {
                    addTask;
                    } ;
                   }
                ),
      
          ],
        ),
      ),
    );
  }
  void addTask () {
    TaskMdoel task =TaskMdoel(
      title: titleController.text ,
      description: descriptionController.text ,
      date:selectedDate ,
     
      
    );
  }
}