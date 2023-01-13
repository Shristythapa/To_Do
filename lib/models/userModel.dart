// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.userName,
        required this.email,
        required this.password,
    });

    String userName;
    String email;
    String password;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userName: json["userName"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "userName": userName,
        "email": email,
        "password": password,
    };
}
