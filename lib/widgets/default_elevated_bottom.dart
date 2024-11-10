import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';

class DefaultElevatedBottom extends StatelessWidget {
  String label;
  VoidCallback onPressed;
  DefaultElevatedBottom({required this.label, required this.onPressed});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.sizeOf(context).width*.8, 52)
        ),
       child: Text(label,
       style: Theme.of(context).textTheme.titleMedium ?.copyWith(
        fontWeight: FontWeight.w400,
        color: AppTheme.white 
       ),
       )
       
       );
  }
}