
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
 
    Task({
        required this.userId,
        required this.task,
        required this.date,
        required this.time,
    });

    String userId;
    String task;
    String date;
    String time;

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        userId: json["user_id"],
        task: json["task"],
        date: json["date"],
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "task": task,
        "date": date,
        "time": time,
    };

      factory Task.fromFirebaseSnapshot(DocumentSnapshot<Map<String, dynamic>> json) => Task(
    userId: json.id,
    task: json["task"],
    date: json["date"],
    time: json["time"]
 
  );
}


  