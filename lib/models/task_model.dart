// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
    Task({

        required this.userId,
        required this.task,
        required this.date,
        required this.time,
        required this.status,
    });

    String userId;

    String task;
    String date;
    String time;
    bool status;

    factory Task.fromJson(DocumentSnapshot<Map<String, dynamic>> json) => Task(
 
        userId:json["user_id"],
        task: json["task"],
        date: json["date"],
        time: json["time"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
      
        "user_id": userId,
        "task": task,
        "date": date,
        "time": time,
        "status": status,
    };
    
      factory Task.fromFirebaseSnapshot(DocumentSnapshot<Map<String, dynamic>> json) => Task(
   
    userId:json["user_id"],
    
    task: json["task"],
    date: json["date"],
    time: json["time"],
    status: json["status"]
 
  );
}


