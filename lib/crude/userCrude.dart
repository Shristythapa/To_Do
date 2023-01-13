import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:time_me/models/userModel.dart';

Future<void> addUser({ required String user_name, required String email, required String pass_word, context}) async{
  FirebaseFirestore db = FirebaseFirestore.instance;
  final data = UserModel(
    userName: user_name,
    email: email,
    password: pass_word
  );

  db.collection("user").add(data.toJson()).then((value){
       print("user Added");
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product Added")));
  });
}