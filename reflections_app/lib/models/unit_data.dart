import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:reflections_app/models/reflection.dart';

class UnitData with ChangeNotifier {
  static Future<List<Reflection>> fetchData() async {
    Map<String, dynamic> _map = {};
    List<Reflection> _onlineJson = [];

    final response = await get(
      Uri.parse(
          "https://dl.dropboxusercontent.com/s/q6chvs5eqktd1nb/unitReflections.json?dl=0"),
    );
    if (response.statusCode == 200) {
      try {
        _map = jsonDecode(response.body);

        for (var i in _map.values) {
          _onlineJson.add(
              Reflection(title: i["unitDesc"], reflection: i["reflections"]));
        }
      } catch (e) {
        _map = {};
      }
    } else {
      _map = {};
    }

    return _onlineJson;
  }
}

// class UnitData with ChangeNotifier {
//   static Future<List<Reflection>> fetchData() async {
//     Map<String, dynamic> _map = {};
//     List<Reflection> _onlineJson = [];

//     final response = await get(
//       Uri.parse(
//           "https://dl.dropboxusercontent.com/s/q6chvs5eqktd1nb/unitReflections.json?dl=0"),
//     );
//     if (response.statusCode == 200) {
//       try {
//         _map = jsonDecode(response.body);

//         for (var i in _map.values) {
//           _onlineJson.add(
//               Reflection(title: i["unitDesc"], reflection: i["reflections"]));
//         }
//       } catch (e) {
//         _map = {};
//       }
//     } else {
//       _map = {};
//     }

//     return _onlineJson;
//   }
// }
