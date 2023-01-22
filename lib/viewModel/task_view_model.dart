import 'package:flutter/cupertino.dart';
import 'package:to_do/repo/task_repo.dart';

import '../models/task_model.dart';

class TaskViewModel with ChangeNotifier{
  Future<void> addTask(Task task ) async{
    try{
      await TaskRepo().addTask(task: task);
    } catch(err){
      rethrow;
    }
  }
}