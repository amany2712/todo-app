import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/edit_screen.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class TaskItem extends StatelessWidget {
 final TaskModel task;
 const TaskItem( this.task,{super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);         //Because I use themes a lot
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);

    return Container(
       margin: EdgeInsets.symmetric(vertical: 8,horizontal: 20),

      child: Slidable(
        startActionPane: ActionPane(
      // A motion is a widget used to control how the pane animates.
      motion: const ScrollMotion(),
      // All actions are defined in the children parameter.
      children:  [
        // A SlidableAction can have an icon and/or a label.
        SlidableAction(
          onPressed: (_) {
            FirebaseFunctions.DeleteTaskFromFirestore(task.id)
            .timeout(
              Duration(microseconds: 100),
              onTimeout: () => Provider.of<TasksProvider>(context, listen: false).getTasks()
              )
            .catchError((_){
                Fluttertoast.showToast(
                  msg: "Something went wrong",
                 toastLength: Toast.LENGTH_LONG,  //in android & IOS only
                 timeInSecForIosWeb: 1,  //in web
                 backgroundColor: Colors.red,
                 textColor: Colors.white,
                 fontSize: 16.0
                 );
              });
          },
          backgroundColor: AppTheme.red,
          foregroundColor: AppTheme.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
        
        SlidableAction(
        onPressed: (_) {
          Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditScreen(task), 
                      ),
                    );
        },
        backgroundColor: Color(0xFF21B7CA),
        foregroundColor: Colors.white,
        icon: Icons.edit,
        label: 'Edit',
      ),
        
      ],
      ),            
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.all(Radius.circular(15))
      
          ),
          child: Row(
            children: [
              Container(
                height: 62,
                width: 4,
                margin: EdgeInsetsDirectional.only(end: 12),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   task.title,
                   style: theme.textTheme.titleMedium ?.copyWith(color: theme.primaryColor),
                   ),
                  SizedBox(height: 5,),
                  Text(
                    task.description,
                    style: theme.textTheme.titleSmall,
                   )
                ],
              ),
      
              Spacer(),
      
              Container(
                height: 34,
                width: 69,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))
      
                ),
                child: GestureDetector(
                 onTap: () async {
                  task.isDone = ! task.isDone;
                  await FirebaseFunctions.updateTaskInFirestore(task).timeout(
                    const Duration(milliseconds: 10),
                    onTimeout: (){
                      tasksProvider.getTasks();
                    }
                    );
                 },
                  child:task.isDone
                      ? Container(
                        margin: EdgeInsets.zero, 
                        padding: EdgeInsets.zero, 
                       decoration: BoxDecoration(
                       color: AppTheme.white,
                        borderRadius: BorderRadius.zero,),
                        child: Text(
                            "Done!",
                            style: TextStyle(
                              color: AppTheme.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                      )
                      : Icon(
                          Icons.check,
                          size: 24,
                          color: AppTheme.white,
                        ),
                ),
                
              )
            ],
          ),
      
      
      
        ),
      ),
    );
  }
}