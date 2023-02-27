

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/Screens/tasks/task_tile.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/services/firebase_services.dart';

class TaskRepo {
  CollectionReference<Task> taskRef =
      FirebaseService.db.collection("task").withConverter<Task>(
            fromFirestore: (snapshot, _) {
              return Task.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );

  Future<void> addTask({required Task task}) async {
    try {
      var docref = taskRef.doc();
      task.id=docref.id;
      await docref.set(task);
    } catch (err) {
      rethrow;
    }
  }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   

   Future<List<QueryDocumentSnapshot<Task>>> getTask(String user_id)  async{
     try{
      final response = await taskRef.where('user_id',isEqualTo: user_id).get();
      var task = response.docs;
      return task;
     }catch(err){
      rethrow;
     }
  }

  Future<void> deleteTask(String id) async{
     try{
      await taskRef.doc(id).delete();
     }catch(e){
      print(e);
      rethrow;
     }
  }

  Future<void> updateTask(Task task) async{
     var doc =task.id;
     print("reached");
    try{
      print("update");
     await taskRef.doc(doc).set(task);
    }catch(e){
      print(e);
      rethrow;
    }

  }

}
