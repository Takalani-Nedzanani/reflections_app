// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reflections_app/services/reflection_service.dart';
import 'package:reflections_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LifeCycle extends StatefulWidget {
  const LifeCycle({super.key, required this.child});
  final Widget child;

  @override
  State<LifeCycle> createState() => _LifeCycleState();
}

class _LifeCycleState extends State<LifeCycle> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    int check = await getCheckFlag();
    if (check == 1 &&
        state == AppLifecycleState.inactive &&
        context.read<UserService>().currentUser!.email != null) {
      await context.read<ReflectionService>().saveReflectionEntry(
          context.read<UserService>().currentUser!.email, false);
      setCheckFlag(0);
    }

    // super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

void setCheckFlag(int value) async {
  SharedPreferences prets = await SharedPreferences.getInstance();
  prets.setInt("check", value);
}

Future<int> getCheckFlag() async {
  SharedPreferences prets = await SharedPreferences.getInstance();
  return prets.getInt("check") ?? 0;
}

// class LifeCycle extends StatefulWidget {
//   const LifeCycle({super.key, required this.child});
//   final Widget child;

//   @override
//   State<LifeCycle> createState() => _LifeCycleState();
// }

// class _LifeCycleState extends State<LifeCycle> with WidgetsBindingObserver {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {
//     int check = await getCheckFlag();
//     if (check == 1 &&
//         state == AppLifecycleState.inactive &&
//         context.read<UserService>().currentUser!.email != null) {
//       await context.read<ReflectionService>().saveReflectionEntry(
//           context.read<UserService>().currentUser!.email, false);
//       setCheckFlag(0);
//     }

//     // super.didChangeAppLifecycleState(state);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }

// void setCheckFlag(int value) async {
//   SharedPreferences prets = await SharedPreferences.getInstance();
//   prets.setInt("check", value);
// }

// Future<int> getCheckFlag() async {
//   SharedPreferences prets = await SharedPreferences.getInstance();
//   return prets.getInt("check") ?? 0;
// }
