import 'package:flutter/material.dart';

class GlobalUIViewModel with ChangeNotifier{
  bool _isLoading = false;
  bool  get isLoading =>_isLoading;

  loadState(bool _state){
    _isLoading = _state;
    notifyListeners();
  }

}