import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reflections_app/lifecycle.dart';
import 'package:reflections_app/models/reflection_model.dart';
import 'package:reflections_app/routes/routes.dart';
import 'package:reflections_app/services/reflection_service.dart';
import 'package:reflections_app/services/user_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserService(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReflectionViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReflectionService(),
        )
      ],
      child: const LifeCycle(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RouteManager.loadingPage,
          onGenerateRoute: RouteManager.generateRoute,
        ),
      ),
    );
  }
}
