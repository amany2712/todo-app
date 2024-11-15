import 'package:flutter/material.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';

class TasksProvider with ChangeNotifier{
  List <TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();

  Future <void> getTasks ( String userId) async {
    
  List <TaskModel>  allTasks = 
      await FirebaseFunctions.getAllTasksFromFirestore(userId);

    
    tasks = allTasks.where((task) => 
       task.date.year == selectedDate.year &&
       task.date.month == selectedDate.month &&
       task.date.day == selectedDate.day 
      
      )
     .toList();           //Return the tasks I did on the same day, month and year
    notifyListeners();
 
  }

 void getSelectedDateTasks (DateTime date, String userId){
    selectedDate = date;
    getTasks(userId);

  }

  
}