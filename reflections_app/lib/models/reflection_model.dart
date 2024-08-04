// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';

import 'package:reflections_app/models/reflection.dart';
import 'package:reflections_app/models/unit_data.dart';

class ReflectionViewModel with ChangeNotifier {
  ReflectionViewModel() {
    fetchReflectionData();
  }

  List<Reflection> _reflections = [];
  List<Reflection> get reflections => _reflections;

  Reflection? _selectedReflection;
  Reflection? get selectedReflection => _selectedReflection;
  set selectedReflection(Reflection? reflection) {
    _selectedReflection = reflection;
    //we Asign (Reflection)_selectedReflection to the list of the online json data that we get from the UnitData class
    notifyListeners();
  }

  bool _error = false;
  bool get error => _error;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  void startError(String message) {
    _error = true;
    _errorMessage = message;
    notifyListeners();
  }

  void stopError() {
    _error = false;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  String _loadingMessage = '';
  String get loadingMessage => _loadingMessage;

  void startLoading(String message) {
    _loading = true;
    _loadingMessage = message;
    notifyListeners();
  }

  void stopLoading() {
    _loading = false;
    notifyListeners();
  }

  void fetchReflectionData() async {
    startLoading('Loading reflections...please wait...');

    try {
      _reflections = await UnitData.fetchData();

      //We are saving the online json data list from the UniData class to the declared empty list called reflections
      stopLoading();
    } catch (e) {
      stopLoading();
      startError(e.toString());
    }
  }
}
// class ReflectionViewModel with ChangeNotifier {
//   ReflectionViewModel() {
//     fetchReflectionData();
//   }

//   List<Reflection> _reflections = [];
//   List<Reflection> get reflections => _reflections;

//   Reflection? _selectedReflection;
//   Reflection? get selectedReflection => _selectedReflection;
//   set selectedReflection(Reflection? reflection) {
//     _selectedReflection = reflection;
//     notifyListeners();
//   }

//   bool _error = false;
//   bool get error => _error;

//   String _errorMessage = '';
//   String get errorMessage => _errorMessage;

//   void startError(String message) {
//     _error = true;
//     _errorMessage = message;
//     notifyListeners();
//   }

//   void stopError() {
//     _error = false;
//     notifyListeners();
//   }

//   bool _loading = false;
//   bool get loading => _loading;

//   String _loadingMessage = '';
//   String get loadingMessage => _loadingMessage;

//   void startLoading(String message) {
//     _loading = true;
//     _loadingMessage = message;
//     notifyListeners();
//   }

//   void stopLoading() {
//     _loading = false;
//     notifyListeners();
//   }

//   void fetchReflectionData() async {
//     startLoading('Loading reflections...please wait...');

//     try {
//       _reflections = await UnitData.fetchData();
//       stopLoading();
//     } catch (e) {
//       stopLoading();
//       startError(e.toString());
//     }
//   }
// }
