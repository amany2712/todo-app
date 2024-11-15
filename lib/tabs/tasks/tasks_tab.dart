import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/tabs/tasks/task_item.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TasksTab extends StatefulWidget {
  

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  bool shouldGetTasks = true ;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);   //because to access 
    String userId = Provider.of<UserProvider>(context,listen: false).CurrentUser!.id;

   if (shouldGetTasks) {
     
    tasksProvider.getTasks(userId);
    shouldGetTasks = false ;
    }
    
   

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: screenHeight*.15,
              width: double.infinity,
              color: AppTheme.primary,
            ),
            PositionedDirectional(
              start: 20,
              child: SafeArea(
                child: Text(AppLocalizations.of(context)!.todoList,
                style: Theme.of(context).textTheme.titleMedium ?.copyWith(
                  color: AppTheme.white,
                  fontSize: 22,
                ),
                ),
              ),
            ),
         
          //calender
         Padding(
           padding:  EdgeInsets.only(top: screenHeight*0.1),
           child: EasyInfiniteDateTimeLine(
            firstDate: DateTime.now().subtract(Duration(days:365)) , //Subtract a year from the current date
            focusDate: tasksProvider.selectedDate ,
            lastDate:DateTime.now().add(Duration(days: 365)) ,  //Add one year from the current date
            onDateChange: (selectedDate) {
                tasksProvider.getSelectedDateTasks(selectedDate,userId);   //This made me know how to switch days
               // tasksProvider.getTasks();   //And also bring me the tasks that are available on the day that you chose.
              } ,
            showTimelineHeader: false,
         
            dayProps: EasyDayProps(
              height: 79,
              width: 58,
         
              dayStructure: DayStructure.dayStrDayNum,
              activeDayStyle:DayStyle(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(5),
                ),
         
                dayNumStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary
                ) ,
         
                dayStrStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary
                ) , 
              ), 
         
              inactiveDayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                dayNumStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.black
                ) ,
         
                dayStrStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.black
                ) , 
              ),

              todayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                dayNumStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.black
                ) ,
         
                dayStrStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.black
                ) , 
              )
              )
            ),
         ),
          ],
        ),
          
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 25),
            itemBuilder: (_,index)=> TaskItem(tasksProvider.tasks[index]) ,
            itemCount:tasksProvider.tasks.length, 
            ),
        ),
      ],
    ); 
  }

  
}