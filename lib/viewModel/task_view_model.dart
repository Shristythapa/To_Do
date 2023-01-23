import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do/repo/task_repo.dart';

import '../models/task_model.dart';

class TaskViewModel with ChangeNotifier{
  TaskRepo _taskRepo = TaskRepo();
  Stream<QuerySnapshot<Task>>? _tasks;
  Stream<QuerySnapshot<Task>>? get tasks => _tasks;
  
  Future<void> getTasks() async{
    var response = _taskRepo.getData();

    _tasks = response;
    notifyListeners();//changes has been made
  }
  Future<void> addTask(Task task ) async{
    try{
      await TaskRepo().addTask(task: task);
    } catch(err){
      rethrow;
    }
  }
}