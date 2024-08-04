// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:provider/provider.dart';
import 'package:reflections_app/routes/routes.dart';
import 'package:reflections_app/services/reflection_service.dart';
import 'package:reflections_app/services/user_service.dart';

class InitApp {
  static const String apiKeyAndroid = '0FA0F0A8-EE61-49E5-8C29-1A6B54F2689E';
  static const String apiKeyiOS = '88EC556D-21E1-4922-9A60-273E6F8C032C';
  static const String appID = 'D74FFFCC-CC89-E7CC-FF99-41E7F6C12F00';

  static void initializeApp(BuildContext context) async {
    await Backendless.initApp(
        applicationId: appID,
        iosApiKey: apiKeyiOS,
        androidApiKey: apiKeyAndroid);
    String result = await context.read<UserService>().checkIfUserLoggedIn();
    if (result == 'OK') {
      context
          .read<ReflectionService>()
          .getReflections(context.read<UserService>().currentUser!.email);
      Navigator.popAndPushNamed(context, RouteManager.reflectionPage);
    } else {
      Navigator.popAndPushNamed(context, RouteManager.loginPage);
    }
  }
}
