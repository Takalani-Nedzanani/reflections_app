// ignore_for_file: body_might_complete_normally_nullable

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:reflections_app/models/unit_entry.dart';

class UserService with ChangeNotifier {
  BackendlessUser? _currentUser;
  BackendlessUser? get currentUser => _currentUser;

  void setCurrentUserNull() {
    _currentUser = null;
  }

  bool _userExists = false;
  bool get userExists => _userExists;

  set userExists(bool value) {
    _userExists = value;
    notifyListeners();
  }

  bool _showUserProgress = false;
  bool get showUserProgress => _showUserProgress;

  String _userProgressText = "";
  String get userProgressText => _userProgressText;

  Future<String> resetPassword(String username) async {
    String result = 'OK';
    _showUserProgress = true;
    _userProgressText = "Reseting password...";
    notifyListeners();

    await Backendless.userService
        .restorePassword(username)
        .onError((error, stackTrace) {
      result = getHumanReadableError(error.toString());
    });

    _showUserProgress = false;
    notifyListeners();
    return result;
  }

  Future<String> loginUser(String username, String password) async {
    String result = 'OK';
    _showUserProgress = true;
    _userProgressText = "logging in...";
    notifyListeners();

    BackendlessUser? user = await Backendless.userService
        .login(username, password, true)
        .onError((error, stackTrace) {
      result = getHumanReadableError(error.toString());
    });

    if (user != null) {
      _currentUser = user;
    }
    _showUserProgress = false;
    notifyListeners();

    return result;
  }

  Future<String> logoutUser() async {
    String result = 'OK';
    _showUserProgress = true;
    _userProgressText = "logging out...";
    notifyListeners();

    await Backendless.userService.logout().onError((error, stackTrace) {
      result = error.toString();
    });
    _showUserProgress = false;
    notifyListeners();
    return result;
  }

  Future<String> checkIfUserLoggedIn() async {
    String result = 'OK';

    bool? validLogin = await Backendless.userService
        .isValidLogin()
        .onError((error, stackTrace) {
      result = error.toString();
    });
    if (validLogin != null && validLogin) {
      String? currentUserObjectId = await Backendless.userService
          .loggedInUser()
          .onError((error, stackTrace) {
        result = error.toString();
      });
      if (currentUserObjectId != null) {
        Map<dynamic, dynamic>? mapofCurrentUser = await Backendless.data
            .of("Users")
            .findById(currentUserObjectId)
            .onError((error, stackTrace) {
          result = error.toString();
        });
        if (mapofCurrentUser != null) {
          _currentUser = BackendlessUser.fromJson(mapofCurrentUser);
          notifyListeners();
        } else {
          result = "NOT OK";
        }
      } else {
        result = "NOT OK";
      }
    } else {
      result = "NOT OK";
    }

    return result;
  }

  void checkIfUserExists(String username) async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "email = '$username'";

    await Backendless.data
        .withClass<BackendlessUser>()
        .find(queryBuilder)
        .then((value) {
      if (value == null || value.length == 0) {
        _userExists = false;
        notifyListeners();
      } else {
        _userExists = true;
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  Future<String> createUser(BackendlessUser user) async {
    String result = 'OK';

    _showUserProgress = true;
    _userProgressText = "Creating a new user...";
    notifyListeners();
    try {
      await Backendless.userService.register(user);
      //Add the json file here to appear automatically

      UnitEntry emptyEntry = UnitEntry(units: {}, username: user.email);
      await Backendless.data
          .of("UnitEntry")
          .save(emptyEntry.toJson())
          .onError((error, stackTrace) {
        result = error.toString();
      });
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    _showUserProgress = false;
    notifyListeners();
    return result;
  }
}

String getHumanReadableError(String message) {
  if (message.contains('email address must be confirmed first')) {
    return 'Please check your inbox and confirm your email address and try to login again.';
  }
  if (message.contains('User already exists')) {
    return 'This user already exists in our database. Please create a new user.';
  }
  if (message.contains('Invalid login or password')) {
    return 'Please check your username or password. The combination do not match any entry in our database.';
  }
  if (message
      .contains('User account is locked out due to too many failed logins')) {
    return 'Your account is locked due to too many failed login attempts. Please wait 30 minutes and try again.';
  }
  if (message.contains('Unable to find a user with the specified identity')) {
    return 'Your email address does not exist in our database. Please check for spelling mistakes.';
  }
  if (message.contains(
      'Unable to resolve host "api.backendless.com": No address associated with hostname')) {
    return 'It seems as if you do not have an internet connection. Please connect and try again.';
  }
  return message;
}

// class UserService with ChangeNotifier {
//   BackendlessUser? _currentUser;
//   BackendlessUser? get currentUser => _currentUser;

//   void setCurrentUserNull() {
//     _currentUser = null;
//   }

//   bool _userExists = false;
//   bool get userExists => _userExists;

//   set userExists(bool value) {
//     _userExists = value;
//     notifyListeners();
//   }

//   bool _showUserProgress = false;
//   bool get showUserProgress => _showUserProgress;

//   String _userProgressText = "";
//   String get userProgressText => _userProgressText;

//   Future<String> resetPassword(String username) async {
//     String result = 'OK';
//     _showUserProgress = true;
//     _userProgressText = "Reseting password...";
//     notifyListeners();

//     await Backendless.userService
//         .restorePassword(username)
//         .onError((error, stackTrace) {
//       result = getHumanReadableError(error.toString());
//     });

//     _showUserProgress = false;
//     notifyListeners();
//     return result;
//   }

//   Future<String> loginUser(String username, String password) async {
//     String result = 'OK';
//     _showUserProgress = true;
//     _userProgressText = "logging in...";
//     notifyListeners();

//     BackendlessUser? user = await Backendless.userService
//         .login(username, password, true)
//         .onError((error, stackTrace) {
//       result = getHumanReadableError(error.toString());
//     });

//     if (user != null) {
//       _currentUser = user;
//     }
//     _showUserProgress = false;
//     notifyListeners();

//     return result;
//   }

//   Future<String> logoutUser() async {
//     String result = 'OK';
//     _showUserProgress = true;
//     _userProgressText = "logging out...";
//     notifyListeners();

//     await Backendless.userService.logout().onError((error, stackTrace) {
//       result = error.toString();
//     });
//     _showUserProgress = false;
//     notifyListeners();
//     return result;
//   }

//   Future<String> checkIfUserLoggedIn() async {
//     String result = 'OK';

//     bool? validLogin = await Backendless.userService
//         .isValidLogin()
//         .onError((error, stackTrace) {
//       result = error.toString();
//     });
//     if (validLogin != null && validLogin) {
//       String? currentUserObjectId = await Backendless.userService
//           .loggedInUser()
//           .onError((error, stackTrace) {
//         result = error.toString();
//       });
//       if (currentUserObjectId != null) {
//         Map<dynamic, dynamic>? mapofCurrentUser = await Backendless.data
//             .of("Users")
//             .findById(currentUserObjectId)
//             .onError((error, stackTrace) {
//           result = error.toString();
//         });
//         if (mapofCurrentUser != null) {
//           _currentUser = BackendlessUser.fromJson(mapofCurrentUser);
//           notifyListeners();
//         } else {
//           result = "NOT OK";
//         }
//       } else {
//         result = "NOT OK";
//       }
//     } else {
//       result = "NOT OK";
//     }

//     return result;
//   }

//   void checkIfUserExists(String username) async {
//     DataQueryBuilder queryBuilder = DataQueryBuilder()
//       ..whereClause = "email = '$username'";

//     await Backendless.data
//         .withClass<BackendlessUser>()
//         .find(queryBuilder)
//         .then((value) {
//       if (value == null || value.length == 0) {
//         _userExists = false;
//         notifyListeners();
//       } else {
//         _userExists = true;
//         notifyListeners();
//       }
//     }).onError((error, stackTrace) {
//       print(error.toString());
//     });
//   }

//   Future<String> createUser(BackendlessUser user) async {
//     String result = 'OK';

//     _showUserProgress = true;
//     _userProgressText = "Creating a new user...";
//     notifyListeners();
//     try {
//       await Backendless.userService.register(user);
//       //Add the json file here to appear automatically

//       UnitEntry emptyEntry = UnitEntry(units: {}, username: user.email);
//       await Backendless.data
//           .of("UnitEntry")
//           .save(emptyEntry.toJson())
//           .onError((error, stackTrace) {
//         result = error.toString();
//       });
//     } catch (e) {
//       result = getHumanReadableError(e.toString());
//     }
//     _showUserProgress = false;
//     notifyListeners();
//     return result;
//   }
// }

// String getHumanReadableError(String message) {
//   if (message.contains('email address must be confirmed first')) {
//     return 'Please check your inbox and confirm your email address and try to login again.';
//   }
//   if (message.contains('User already exists')) {
//     return 'This user already exists in our database. Please create a new user.';
//   }
//   if (message.contains('Invalid login or password')) {
//     return 'Please check your username or password. The combination do not match any entry in our database.';
//   }
//   if (message
//       .contains('User account is locked out due to too many failed logins')) {
//     return 'Your account is locked due to too many failed login attempts. Please wait 30 minutes and try again.';
//   }
//   if (message.contains('Unable to find a user with the specified identity')) {
//     return 'Your email address does not exist in our database. Please check for spelling mistakes.';
//   }
//   if (message.contains(
//       'Unable to resolve host "api.backendless.com": No address associated with hostname')) {
//     return 'It seems as if you do not have an internet connection. Please connect and try again.';
//   }
//   return message;
// }
