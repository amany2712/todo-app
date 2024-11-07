import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);         //Because I use themes a lot

    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
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
              Text('Play basket ball',
               style: theme.textTheme.titleMedium ?.copyWith(color: theme.primaryColor),
               ),
              SizedBox(height: 5,),
              Text('task discription task discription ',
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
            child: Icon(
              Icons.check,
              size: 33,
              color: AppTheme.white,
              ),
            
          )
        ],
      ),



    );
  }
}