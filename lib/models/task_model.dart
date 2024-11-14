import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel{
  String id;       // id is used in update and delete 
  String title ;
  String description;
  DateTime date;
  bool isDone ;

  TaskModel ({
    this.id = '',
    required this.title,
    required this.description,
    required this.date ,
    this.isDone = false
    }
    );
    // Convert to a map for Firebase storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(date),
      'isDone': isDone,
    };
  }
  // Create a TaskModel from a Firebase map
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      isDone: map['isDone'] ?? false,
    );
  }

     //covert from JSON to TaskModel
    TaskModel.fromJson (Map <String, dynamic> json) 
        : this(
         id: json['id'],
         title: json ['title'],
         description :json ['description'],
         date : (json['date'] as Timestamp).toDate(),
         isDone: json ['isDone'],
        );
   //convert from TakModel to JSON
   Map <String , dynamic> toJson() => {
       'id': id,
       'title': title,
       'description' : description,
       'date' : Timestamp.fromDate(date),
       'isDone': isDone


      };

}