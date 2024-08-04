import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reflections_app/routes/routes.dart';

import 'package:reflections_app/services/helper_user.dart';
import 'package:reflections_app/services/user_service.dart';
import 'package:reflections_app/widgets/app_progress.dart';
import 'package:reflections_app/widgets/app_textfield.dart';
import 'package:tuple/tuple.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 209, 209, 209)),
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 40.0),
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 46,
                          fontWeight: FontWeight.w200,
                          color: Color.fromARGB(255, 29, 29, 29),
                        ),
                      ),
                    ),
                    AppTextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: usernameController,
                      labelText: 'Please enter email address',
                    ),
                    AppTextField(
                      hideText: true,
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      labelText: 'Please enter your password',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: ElevatedButton(
                        onPressed: () {
                          loginUserInUI(context,
                              email: usernameController.text,
                              password: passwordController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 155, 155, 155),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Color.fromARGB(255, 29, 29, 29),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RouteManager.registerPage);
                      },
                      child: const Text(
                        'Register a new User',
                        style: TextStyle(
                          color: Color.fromARGB(255, 29, 29, 29),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        resetPasswordInUI(context,
                            email: usernameController.text);
                      },
                      child: const Text(
                        'Reset Password',
                        style: TextStyle(
                          color: Color.fromARGB(255, 29, 29, 29),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Selector<UserService, Tuple2>(
              builder: (context, value, child) {
                return value.item1
                    ? AppProgressIndicator(
                        text: "${value.item2}",
                      )
                    : Container();
              },
              selector: (context, value) => Tuple2(
                value.showUserProgress,
                value.userProgressText,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);

//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   late TextEditingController usernameController;
//   late TextEditingController passwordController;

//   @override
//   void initState() {
//     super.initState();
//     usernameController = TextEditingController();
//     passwordController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     usernameController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.purple, Colors.blue],
//           ),
//         ),
//         child: Stack(
//           children: [
//             Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(bottom: 40.0),
//                       child: Text(
//                         'Welcome',
//                         style: TextStyle(
//                             fontSize: 46,
//                             fontWeight: FontWeight.w200,
//                             color: Colors.white),
//                       ),
//                     ),
//                     AppTextField(
//                       keyboardType: TextInputType.emailAddress,
//                       controller: usernameController,
//                       labelText: 'Please enter email address',
//                     ),
//                     AppTextField(
//                       hideText: true,
//                       keyboardType: TextInputType.text,
//                       controller: passwordController,
//                       labelText: 'Please enter your password',
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 12.0),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           loginUserInUI(context,
//                               email: usernameController.text,
//                               password: passwordController.text);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.purple,
//                         ),
//                         child: Text('Login'),
//                       ),
//                     ),
//                     TextButton(
//                       style: TextButton.styleFrom(
//                         foregroundColor: Colors.white,
//                       ),
//                       onPressed: () {
//                         Navigator.of(context)
//                             .pushNamed(RouteManager.registerPage);
//                       },
//                       child: const Text('Register a new User'),
//                     ),
//                     TextButton(
//                       style: TextButton.styleFrom(
//                         foregroundColor: Colors.white,
//                       ),
//                       onPressed: () async {
//                         resetPasswordInUI(context,
//                             email: usernameController.text);
//                       },
//                       child: Text('Reset Password'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Selector<UserService, Tuple2>(
//               builder: (context, value, child) {
//                 return value.item1
//                     ? AppProgressIndicator(
//                         text: "${value.item2}",
//                       )
//                     : Container();
//               },
//               selector: (context, value) => Tuple2(
//                 value.showUserProgress,
//                 value.userProgressText,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
