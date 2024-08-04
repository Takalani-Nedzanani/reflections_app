import 'package:flutter/material.dart';

class UnitsCreatePage extends StatelessWidget {
  const UnitsCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 209, 209, 209),
          title: const Text(
            'UnitsCreate Page',
            style: TextStyle(
              color: Color.fromARGB(255, 29, 29, 29),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(),
        ));
  }
}
// class UnitsCreatePage extends StatelessWidget {
//   const UnitsCreatePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('UnitsCreate Page'),
//         ),
//         body: SingleChildScrollView(
//           child: Container(),
//         ));
//   }
// }
