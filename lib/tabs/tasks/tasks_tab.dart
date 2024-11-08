import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/task_item.dart';

class TasksTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    List <TaskMdoel> tasks = List.generate(10, (index) => TaskMdoel(
      title: 'Title $index',
      description: 'Description $index',
      date: DateTime.now())
      );


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
                child: Text('To Do List',
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
            focusDate:DateTime.now() ,
            lastDate:DateTime.now().add(Duration(days: 365)) ,  //Add one year from the current date
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
              )
              )
            ),
         ),
          ],
        ),
          
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 25),
            itemBuilder: (_,index)=> TaskItem(tasks[index]) ,
            itemCount: tasks.length, 
            ),
        ),
      ],
    ); 
  }
}