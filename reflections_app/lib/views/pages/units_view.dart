import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reflections_app/models/reflection.dart';
import 'package:reflections_app/models/reflection_model.dart';

class UnitsPage extends StatelessWidget {
  const UnitsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 209, 209, 209),
        title: const Text(
          'Units Page',
          style: TextStyle(
            color: Color.fromARGB(255, 29, 29, 29),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Selector<ReflectionViewModel, Reflection>(
          selector: (context, viewModel) => viewModel.selectedReflection!,
          builder: (context, selectedUnits, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    selectedUnits.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(selectedUnits.reflection),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
// class UnitsPage extends StatelessWidget {
//   const UnitsPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Units Page'),
//       ),
//       body: SingleChildScrollView(
//         child: Selector<ReflectionViewModel, Reflection>(
//           selector: (context, viewModel) => viewModel.selectedReflection!,
//           builder: (context, selectedUnits, child) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Text(
//                     selectedUnits.title,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   Text(selectedUnits.reflection),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
