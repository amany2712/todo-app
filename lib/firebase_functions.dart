import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/task_model.dart';

class FirebaseFunctions {
  static CollectionReference <TaskModel> getTasksCollection() => 
    FirebaseFirestore.instance.collection('tasks').withConverter<TaskModel>(
       fromFirestore: (docSnapshot, _) => 
         TaskModel.fromJson(docSnapshot.data()!) ,
       toFirestore: (taskModel, _) => taskModel.toJson(),
       );

  static Future <void> addTaskToFirestore (TaskModel task) {
       CollectionReference <TaskModel> tasksCollection =  getTasksCollection();
       DocumentReference <TaskModel> doc = tasksCollection.doc();
       task.id = doc.id;
       return  doc.set(task);

     }
  static Future<List<TaskModel>> getAllTasksFromFirestore ()async{
      CollectionReference <TaskModel> tasksCollection =  getTasksCollection();
      QuerySnapshot<TaskModel> querySnapshot = await tasksCollection.get();
      return querySnapshot.docs.map((docSnapshot) =>docSnapshot.data()).toList();
      }
  static Future <void> DeleteTaskFromFirestore (String taskId) async {
    CollectionReference <TaskModel> tasksCollection =  getTasksCollection();
    return  tasksCollection.doc(taskId).delete();   //It will bring  the doc that is in this ID and delete

  }

   // Function to edit/update a task
  static Future<void> updateTaskInFirestore(TaskModel task) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection();
    
    return tasksCollection.doc(task.id).update(task.toJson());
  }



}