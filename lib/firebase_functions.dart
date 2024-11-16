import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/models/user_model.dart';

class FirebaseFunctions {
  
  static CollectionReference <UserModel> getUsersCollection() => 
    FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
       fromFirestore: (docSnapshot, _) => 
         UserModel.fromJson(docSnapshot.data()!) ,
       toFirestore: (UserModel, _) => UserModel.toJon(),
       );

  static CollectionReference <TaskModel> getTasksCollection(String userId) => 
   getUsersCollection()
     .doc(userId)
     .collection('tasks')
     .withConverter<TaskModel>(
       fromFirestore: (docSnapshot, _) => 
         TaskModel.fromJson(docSnapshot.data()!) ,
       toFirestore: (taskModel, _) => taskModel.toJson(),
       );


  static Future <void> addTaskToFirestore (TaskModel task, String userId) {
       CollectionReference <TaskModel> tasksCollection =  getTasksCollection(userId);
       DocumentReference <TaskModel> doc = tasksCollection.doc();
       task.id = doc.id;
       return  doc.set(task);

     }
  static Future<List<TaskModel>> getAllTasksFromFirestore ( String userId)async{
      CollectionReference <TaskModel> tasksCollection =  getTasksCollection(userId);
      QuerySnapshot<TaskModel> querySnapshot = await tasksCollection.get();
      return querySnapshot.docs.map((docSnapshot) =>docSnapshot.data()).toList();
      }

  static Future <void> DeleteTaskFromFirestore (String taskId, String userId) async {
    CollectionReference <TaskModel> tasksCollection =  getTasksCollection(userId);
    return  tasksCollection.doc(taskId).delete();   //It will bring  the doc that is in this ID and delete

  }

   // Function to edit/update a task
  static Future<void> updateTaskInFirestore(TaskModel task, String userId) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection(userId);
    
    return tasksCollection.doc(task.id).update(task.toJson());
  }

  static Future <UserModel> register ({
    required String name ,
    required String email ,
    required String password ,
  }) async {
  UserCredential credential = 
     await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email,
       password: password
       );
       UserModel user = UserModel(
         id: credential.user!.uid,
         name: name,
         email: email
          );
      CollectionReference <UserModel> usersCollection = getUsersCollection();
     await usersCollection.doc(user.id).set(user);    //create doc wit user id 
     return user;
  }
  
  static Future <UserModel > login ({
    required String email ,
    required String password
    }) async {
    UserCredential credential = 
       await FirebaseAuth.instance.signInWithEmailAndPassword (
            email: email,
            password: password
          );
     CollectionReference <UserModel> usersCollection = getUsersCollection();
   DocumentSnapshot <UserModel> docSnapshot = 
       await usersCollection.doc(credential.user!.uid).get();
     return docSnapshot.data()!;


  }

  Future <void> logout() => FirebaseAuth.instance.signOut();



}