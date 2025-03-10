import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:reflections_app/services/helper_user.dart';
import 'package:reflections_app/services/user_service.dart';
import 'package:reflections_app/widgets/app_progress.dart';
import 'package:reflections_app/widgets/app_textfield.dart';
import 'package:tuple/tuple.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController usernameController;
  late TextEditingController nameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 209, 209, 209),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Text(
                        'Register User',
                        style: TextStyle(
                          fontSize: 46,
                          fontWeight: FontWeight.w200,
                          color: Color.fromARGB(255, 29, 29, 29),
                        ),
                      ),
                    ),
                    Focus(
                      onFocusChange: (value) async {
                        if (!value) {
                          context.read<UserService>().checkIfUserExists(
                              usernameController.text.trim());
                        }
                      },
                      child: AppTextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: usernameController,
                        labelText: 'Please enter your email address',
                      ),
                    ),
                    Selector<UserService, bool>(
                      builder: (context, value, child) {
                        return value
                            ? const Text(
                                "Username exists",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            : Container();
                      },
                      selector: (context, value) => value.userExists,
                    ),
                    AppTextField(
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      labelText: 'Please enter your name',
                    ),
                    AppTextField(
                      hideText: true,
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      labelText: 'Please enter your password',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 155, 155, 155),
                        ),
                        onPressed: () {
                          createNewUserInUI(context,
                              email: usernameController.text.trim(),
                              password: passwordController.text.trim(),
                              name: nameController.text.trim());
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Color.fromARGB(255, 29, 29, 29),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 30,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          Selector<UserService, Tuple2>(
            builder: (context, value, child) {
              return value.item1
                  ? AppProgressIndicator(text: "${value.item2}")
                  : Container();
            },
            selector: (context, value) =>
                Tuple2(value.showUserProgress, value.userProgressText),
          )
        ],
      ),
    );
  }
}
// class Register extends StatefulWidget {
//   const Register({Key? key}) : super(key: key);

//   @override
//   _RegisterState createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   late TextEditingController usernameController;
//   late TextEditingController nameController;
//   late TextEditingController passwordController;

//   @override
//   void initState() {
//     super.initState();
//     usernameController = TextEditingController();
//     nameController = TextEditingController();
//     passwordController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     usernameController.dispose();
//     nameController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Colors.purple, Colors.blue],
//               ),
//             ),
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(bottom: 30.0),
//                       child: Text(
//                         'Register User',
//                         style: TextStyle(
//                             fontSize: 46,
//                             fontWeight: FontWeight.w200,
//                             color: Colors.white),
//                       ),
//                     ),
//                     Focus(
//                       onFocusChange: (value) async {
//                         if (!value) {
//                           context.read<UserService>().checkIfUserExists(
//                               usernameController.text.trim());
//                         }
//                       },
//                       child: AppTextField(
//                         keyboardType: TextInputType.emailAddress,
//                         controller: usernameController,
//                         labelText: 'Please enter your email address',
//                       ),
//                     ),
//                     Selector<UserService, bool>(
//                       builder: (context, value, child) {
//                         return value
//                             ? const Text(
//                                 "Username exists",
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               )
//                             : Container();
//                       },
//                       selector: (context, value) => value.userExists,
//                     ),
//                     AppTextField(
//                       keyboardType: TextInputType.text,
//                       controller: nameController,
//                       labelText: 'Please enter your name',
//                     ),
//                     AppTextField(
//                       hideText: true,
//                       keyboardType: TextInputType.text,
//                       controller: passwordController,
//                       labelText: 'Please enter your password',
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.purple),
//                         onPressed: () {
//                           createNewUserInUI(context,
//                               email: usernameController.text.trim(),
//                               password: passwordController.text.trim(),
//                               name: nameController.text.trim());
//                         },
//                         child: const Text('Register'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             left: 20,
//             top: 30,
//             child: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: const Icon(
//                 Icons.arrow_back,
//                 size: 30,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           Selector<UserService, Tuple2>(
//             builder: (context, value, child) {
//               return value.item1
//                   ? AppProgressIndicator(text: "${value.item2}")
//                   : Container();
//             },
//             selector: (context, value) =>
//                 Tuple2(value.showUserProgress, value.userProgressText),
//           )
//         ],
//       ),
//     );
//   }
// }
