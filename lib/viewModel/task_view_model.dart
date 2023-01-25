import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do/repo/task_repo.dart';

import '../models/task_model.dart';

class TaskViewModel with ChangeNotifier{
  TaskRepo _taskRepo = TaskRepo();
  
  List<Task> _allTask =[];
  List<Task> get allTask => _allTask;
  
  




  Future<void> addTask(Task task ) async{
    try{
      await TaskRepo().addTask(task: task);
    } catch(err){
      rethrow;
    }
  }


  Future<List<Task>> getTask(String user_id) async{
      _allTask=[];
      notifyListeners();
      try{
        var response = await _taskRepo.getTask(user_id);
        for(var element in response){
          _allTask.add(element.data());
        
        }
      
        notifyListeners();
      }catch(e){
        _allTask=[];
        notifyListeners();
      }
      return _allTask;
  }
}