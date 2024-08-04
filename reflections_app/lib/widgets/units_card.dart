import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reflections_app/models/reflection.dart';

class UnitsCard extends StatelessWidget {
  const UnitsCard({super.key, required this.map, required this.onTap});
  final Reflection map;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 5,
          shadowColor: Colors.black,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(map.title),
                onTap: onTap,
              )),
        ),
      ],
    );
  }
}

// class UnitsCard extends StatelessWidget {
//   const UnitsCard({super.key, required this.map, required this.onTap});
//   // final Map<String, dynamic> map;
//   final Reflection map;
//   final void Function()? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Card(
//           elevation: 5,
//           shadowColor: Colors.black,
//           child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: ListTile(
//                 title: Text(map.title),
//                 onTap: onTap,
//               )),
//         ),
//       ],
//     );
//   }
// }


// // Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const SizedBox(
// //                   height: 15,
// //                 ),
// //                 Text('${map["unitDesc"]}'),
// //                 const SizedBox(
// //                   height: 10,
// //                 ),
// //                 Text('${map["reflections"]}'),
// //                 const SizedBox(
// //                   height: 10,
// //                 ),
// //               ],
// //             ),