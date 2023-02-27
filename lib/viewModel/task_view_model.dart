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
      try{
        print(user_id);
        var response = await _taskRepo.getTask(user_id);
        for(var element in response){
          _allTask.add(element.data());
        }
        notifyListeners();
      }catch(e){
        print(e);
        _allTask=[];
        rethrow;
      }
      notifyListeners();
      return _allTask;

  }

  Future<void> deleteTask(String id, String userId ) async{
    
  
    try{
      await TaskRepo().deleteTask(id).then((value) =>_allTask= TaskRepo().getTask(userId) as List<Task>);
      notifyListeners();
    } catch(err){
      rethrow;
    }
  }

  Future<void> updateTask(Task task) async{
    var doc = task.id;
    try{
      task.status=!task.status;
      await TaskRepo().updateTask(task);
      notifyListeners();
    }catch(e){
      rethrow;
    }
  }



}