

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';
import '../repo/auth_repo.dart';
import '../services/firebase_services.dart';

class AuthViewModel with ChangeNotifier {
  User? _user = FirebaseService.firebaseAuth.currentUser;

  User? get user => _user;

  Future<void> login(String email, String password) async {
    try {
      var response = await AuthRepository().login(email, password);
      _user = response.user;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> register(UserModel user) async {
    print(user.toJson());
    try {
      var response = await AuthRepository().register(user);
      _user = response!.user;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> logout() async{
    try{
      await AuthRepository().logout();
      _user = null;
      notifyListeners();
    }catch(e){
      rethrow;
    }
  }
}
