// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel? userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel? data) => json.encode(data!.toJson());

class UserModel {
    UserModel({
        this.id,
        this.username,
        this.email,
        this.password,
        this.imageurl,
        this.imagepath,
        this.fcm,
    });

    String? id;
    String? username;
    String? email;
    String? password;
    String? imageurl;
    String? imagepath;
    String? fcm;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        imageurl: json["imageurl"],
        imagepath: json["imagepath"],
        fcm: json["fcm"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "imageurl": imageurl,
        "imagepath": imagepath,
        "fcm": fcm,
    };
}
