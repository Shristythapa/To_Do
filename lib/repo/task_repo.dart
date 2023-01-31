

import 'package:cloud_firestore/cloud_firestore.dart';
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
    Map<String, dynamic> jsonAccount = task.toJson();

    try {
      final docref = taskRef.doc();
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

}
