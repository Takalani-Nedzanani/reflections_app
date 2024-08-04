import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reflections_app/routes/routes.dart';

import 'package:reflections_app/services/reflection_service.dart';
import 'package:reflections_app/services/user_service.dart';
import 'package:reflections_app/widgets/dialogs.dart';

void createNewUserInUI(BuildContext context,
    {required String email,
    required String password,
    required String name}) async {
  FocusManager.instance.primaryFocus?.unfocus();

  if (email.isEmpty || name.isEmpty || password.isEmpty) {
    showSnackBar(
      context,
      "Enter all fields",
    );
  } else {
    BackendlessUser user = BackendlessUser()
      ..email = email.trim()
      ..password = password.trim()
      ..putProperties({
        'name': name.trim(),
      });

    String result = await context.read<UserService>().createUser(user);
    if (result != "OK") {
      showSnackBar(context, result);
    } else {
      showSnackBar(context, "Successfuly created a user");
      Navigator.pop(context);
    }
  }
}

void loginUserInUI(BuildContext context,
    {required String email, required String password}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  if (email.isEmpty || password.isEmpty) {
    showSnackBar(context, "Enter all fields");
  } else {
    String result = await context
        .read<UserService>()
        .loginUser(email.trim(), password.trim());
    if (result != "OK") {
      showSnackBar(context, result);
    } else {
      context.read<ReflectionService>().getReflections(email);
      Navigator.of(context).popAndPushNamed(RouteManager.reflectionPage);
    }
  }
}

void resetPasswordInUI(BuildContext context, {required String email}) async {
  if (email.isEmpty) {
    showSnackBar(context, "Enter your email address");
  } else {
    String result =
        await context.read<UserService>().resetPassword(email.trim());
    if (result == "OK") {
      showSnackBar(context, "Successfully sent password reset");
    } else {
      showSnackBar(context, result);
    }
  }
}

void logoutUserInUI(BuildContext context) async {
  String result = await context.read<UserService>().logoutUser();
  if (result == "OK") {
    context.read<UserService>().setCurrentUserNull();
    Navigator.popAndPushNamed(context, RouteManager.loginPage);
  } else {
    showSnackBar(context, result);
  }
}
// void createNewUserInUI(BuildContext context,
//     {required String email,
//     required String password,
//     required String name}) async {
//   FocusManager.instance.primaryFocus?.unfocus();

//   if (email.isEmpty || name.isEmpty || password.isEmpty) {
//     showSnackBar(
//       context,
//       "Enter all fields",
//     );
//   } else {
//     BackendlessUser user = BackendlessUser()
//       ..email = email.trim()
//       ..password = password.trim()
//       ..putProperties({
//         'name': name.trim(),
//       });

//     String result = await context.read<UserService>().createUser(user);
//     if (result != "OK") {
//       showSnackBar(context, result);
//     } else {
//       showSnackBar(context, "Successfuly created a user");
//       Navigator.pop(context);
//     }
//   }
// }

// void loginUserInUI(BuildContext context,
//     {required String email, required String password}) async {
//   FocusManager.instance.primaryFocus?.unfocus();
//   if (email.isEmpty || password.isEmpty) {
//     showSnackBar(context, "Enter all fields");
//   } else {
//     String result = await context
//         .read<UserService>()
//         .loginUser(email.trim(), password.trim());
//     if (result != "OK") {
//       showSnackBar(context, result);
//     } else {
//       context.read<ReflectionService>().getReflections(email);
//       Navigator.of(context).popAndPushNamed(RouteManager.reflectionPage);
//     }
//   }
// }

// void resetPasswordInUI(BuildContext context, {required String email}) async {
//   if (email.isEmpty) {
//     showSnackBar(context, "Enter your email address");
//   } else {
//     String result =
//         await context.read<UserService>().resetPassword(email.trim());
//     if (result == "OK") {
//       showSnackBar(context, "Successfully sent password reset");
//     } else {
//       showSnackBar(context, result);
//     }
//   }
// }

// void logoutUserInUI(BuildContext context) async {
//   String result = await context.read<UserService>().logoutUser();
//   if (result == "OK") {
//     context.read<UserService>().setCurrentUserNull();
//     Navigator.popAndPushNamed(context, RouteManager.loginPage);
//   } else {
//     showSnackBar(context, result);
//   }
// }
