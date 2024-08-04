Map<dynamic, dynamic> convertReflectionListToMap(List<Reflection> reflections) {
  Map<dynamic, dynamic> map = {};
  for (var i = 0; i < reflections.length; i++) {
    map.addAll({'$i': reflections[i].toJson()});
  }
  return map;
}

List<Reflection> convertMapToReflectionList(Map<dynamic, dynamic> map) {
  List<Reflection> reflections = [];
  for (var i = 0; i < map.length; i++) {
    reflections.add(Reflection.fromJson(map['$i']));
  }
  return reflections;
}

class Reflection {
  final String title;
  final String reflection;

  Reflection({
    required this.title,
    required this.reflection,
  });

  Map<String, Object?> toJson() => {
        'title': title,
        'reflection': reflection,
      };

  static Reflection fromJson(Map<dynamic, dynamic>? json) => Reflection(
        title: json!['title'] as String,
        reflection: json['reflection'] as String,
      );

  @override
  bool operator ==(covariant Reflection reflection) {
    return (this
            .title
            .toUpperCase()
            .compareTo(reflection.title.toUpperCase()) ==
        0);
  }

  @override
  int get hashCode {
    return title.hashCode;
  }
}


// Map<dynamic, dynamic> convertReflectionListToMap(List<Reflection> reflections) {
//   Map<dynamic, dynamic> map = {};
//   for (var i = 0; i < reflections.length; i++) {
//     map.addAll({'$i': reflections[i].toJson()});
//   }
//   return map;
// }

// List<Reflection> convertMapToReflectionList(Map<dynamic, dynamic> map) {
//   List<Reflection> reflections = [];
//   for (var i = 0; i < map.length; i++) {
//     reflections.add(Reflection.fromJson(map['$i']));
//   }
//   return reflections;
// }

// class Reflection {
//   final String title;
//   final String reflection;

//   Reflection({
//     required this.title,
//     required this.reflection,
//   });

//   Map<String, Object?> toJson() => {
//         'title': title,
//         'reflection': reflection,
//       };

//   static Reflection fromJson(Map<dynamic, dynamic>? json) => Reflection(
//         title: json!['title'] as String,
//         reflection: json['reflection'] as String,
//       );

//   @override
//   bool operator ==(covariant Reflection reflection) {
//     return (this
//             .title
//             .toUpperCase()
//             .compareTo(reflection.title.toUpperCase()) ==
//         0);
//   }

//   @override
//   int get hashCode {
//     return title.hashCode;
//   }
// }
