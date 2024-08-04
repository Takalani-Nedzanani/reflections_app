// ignore_for_file: body_might_complete_normally_nullable

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:reflections_app/lifecycle.dart';

import 'package:reflections_app/models/reflection.dart';
import 'package:reflections_app/models/unit_entry.dart';

class ReflectionService with ChangeNotifier {
  Reflection? _selectedReflection;
  Reflection? get selectedReflection => _selectedReflection;
  set selectedReflection(Reflection? units) {
    _selectedReflection = units;
    //we Asign (Reflection)_selectedReflection to the list of the online json data that we get from the UnitData class
    notifyListeners();
  }

  //----------------------------------------------------------------------------------------------------
  UnitEntry? _unitEntry;

  List<Reflection> _units = [];
  List<Reflection> get units => _units;

  void emptyReflection() {
    _units = [];
    notifyListeners();
  }

  bool _busyRetrieving = false;
  bool _busySaving = false;

  bool get busyRetrieving => _busyRetrieving;
  bool get busySaving => _busySaving;

  Future<String> getReflections(
    String username,
  ) async {
    String result = 'OK';
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "username = '$username'";

    _busyRetrieving = true;
    notifyListeners();
    List<Map<dynamic, dynamic>?>? map = await Backendless.data
        .of("UnitEntry")
        .find(queryBuilder)
        .onError((error, stackTrace) {
      result = error.toString();
    });

    if (result != "OK") {
      _busyRetrieving = false;
      notifyListeners();
      return result;
    }
    if (map != null) {
      if (map.length > 0) {
        _unitEntry = UnitEntry.fromJson(map.first);
        _units = convertMapToReflectionList(_unitEntry!.units);
        notifyListeners();
      } else {
        emptyReflection();
      }
    } else {
      result = "NOT OK";
    }
    _busyRetrieving = false;
    notifyListeners();
    return result;
  }

  Future<String> saveReflectionEntry(String username, bool inUI) async {
    String result = 'OK';
    // ignore: prefer_conditional_assignment
    if (_unitEntry == null) {
      _unitEntry = UnitEntry(
          units: convertReflectionListToMap(_units), username: username);
    } else {
      _unitEntry!.units = convertReflectionListToMap(_units);
    }

    if (inUI) {
      _busySaving = true;
      notifyListeners();
    }
    await Backendless.data
        .of("UnitEntry")
        .save(_unitEntry!.toJson())
        .onError((error, stackTrace) {
      result = error.toString();
    });
    if (inUI) {
      _busySaving = false;
      notifyListeners();
    }
    return result;
  }

  void deleteReflection(Reflection reflection) {
    _units.remove(reflection);
    notifyListeners();
    setCheckFlag(1);
  }

  void createReflection(Reflection reflection) {
    _units.add(reflection);
    print(_units);
    notifyListeners();
    setCheckFlag(1);
  }
}

// class ReflectionService with ChangeNotifier {
//   UnitEntry? _unitEntry;

//   List<Reflection> _units = [];
//   List<Reflection> get units => _units;

//   void emptyReflection() {
//     _units = [];
//     notifyListeners();
//   }

//   bool _busyRetrieving = false;
//   bool _busySaving = false;

//   bool get busyRetrieving => _busyRetrieving;
//   bool get busySaving => _busySaving;

//   Future<String> getReflections(
//     String username,
//   ) async {
//     String result = 'OK';
//     DataQueryBuilder queryBuilder = DataQueryBuilder()
//       ..whereClause = "username = '$username'";

//     _busyRetrieving = true;
//     notifyListeners();
//     List<Map<dynamic, dynamic>?>? map = await Backendless.data
//         .of("UnitEntry")
//         .find(queryBuilder)
//         .onError((error, stackTrace) {
//       result = error.toString();
//     });

//     if (result != "OK") {
//       _busyRetrieving = false;
//       notifyListeners();
//       return result;
//     }
//     if (map != null) {
//       if (map.length > 0) {
//         _unitEntry = UnitEntry.fromJson(map.first);
//         _units = convertMapToReflectionList(_unitEntry!.units);
//         notifyListeners();
//       } else {
//         emptyReflection();
//       }
//     } else {
//       result = "NOT OK";
//     }
//     _busyRetrieving = false;
//     notifyListeners();
//     return result;
//   }

//   Future<String> saveReflectionEntry(String username, bool inUI) async {
//     String result = 'OK';
//     // ignore: prefer_conditional_assignment
//     if (_unitEntry == null) {
//       _unitEntry = UnitEntry(
//           units: convertReflectionListToMap(_units), username: username);
//     } else {
//       _unitEntry!.units = convertReflectionListToMap(_units);
//     }

//     if (inUI) {
//       _busySaving = true;
//       notifyListeners();
//     }
//     await Backendless.data
//         .of("UnitEntry")
//         .save(_unitEntry!.toJson())
//         .onError((error, stackTrace) {
//       result = error.toString();
//     });
//     if (inUI) {
//       _busySaving = false;
//       notifyListeners();
//     }
//     return result;
//   }

//   void deleteReflection(Reflection reflection) {
//     _units.remove(reflection);
//     notifyListeners();
//     setCheckFlag(1);
//   }

//   void createReflection(Reflection reflection) {
//     _units.insert(0, reflection);
//     notifyListeners();
//     setCheckFlag(1);
//   }
// }
