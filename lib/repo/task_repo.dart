import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/services/firebase_services.dart';

class TaskRepo{
  
    
      CollectionReference<Task> taskRef= FirebaseService.db.collection("task").withConverter<Task>(
        fromFirestore: (snapshot, _){
           return Task.fromFirebaseSnapshot(snapshot);
      },
      toFirestore: (model, _)=>model.toJson(),
      );
     
     
         Future<void> addTask({required Task task}) async {
     Map<String, dynamic> jsonAccount = task.toJson();

     
      try{
        await taskRef.add(task);

      
      }catch(err){
        rethrow;
      }
        
  }
  }
