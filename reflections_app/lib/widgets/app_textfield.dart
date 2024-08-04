import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    this.hideText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final bool hideText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20, right: 20),
      child: TextField(
        obscureText: hideText,
        style: const TextStyle(color: Color.fromARGB(255, 44, 43, 43)),
        cursorColor: Color.fromARGB(255, 36, 8, 8),
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Color.fromARGB(255, 46, 46, 46)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Color.fromARGB(255, 49, 49, 49),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          labelText: labelText,
        ),
      ),
    );
  }
}

// class AppTextField extends StatelessWidget {
//   const AppTextField({
//     Key? key,
//     required this.controller,
//     required this.labelText,
//     required this.keyboardType,
//     this.hideText = false,
//   }) : super(key: key);

//   final TextEditingController controller;
//   final String labelText;
//   final TextInputType keyboardType;
//   final bool hideText;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:
//           const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20, right: 20),
//       child: TextField(
//         obscureText: hideText,
//         style: const TextStyle(color: Colors.white),
//         cursorColor: Colors.white,
//         controller: controller,
//         keyboardType: keyboardType,
//         decoration: InputDecoration(
//           labelStyle: const TextStyle(color: Colors.white),
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(
//               width: 2,
//               color: Colors.white,
//             ),
//           ),
//           enabledBorder: const OutlineInputBorder(
//             borderSide: BorderSide(
//               width: 1,
//               color: Colors.grey,
//             ),
//           ),
//           labelText: labelText,
//         ),
//       ),
//     );
//   }
// }
