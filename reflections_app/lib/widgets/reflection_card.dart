import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:reflections_app/models/reflection.dart';

class ReflectionCard extends StatelessWidget {
  const ReflectionCard({
    Key? key,
    required this.reflection,
    required this.deleteAction,
    required this.onTap,
  }) : super(key: key);

  final Reflection reflection;
  final Function() deleteAction;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Slidable(
            actionPane: const SlidableDrawerActionPane(),
            secondaryActions: [
              IconSlideAction(
                caption: 'Delete',
                icon: Icons.delete,
                onTap: deleteAction,
              ),
            ],
            child: ListTile(
              title: Text(
                reflection.title,
              ),
              onTap: onTap,
            )),
      ),
    );
  }
}


// class ReflectionCard extends StatelessWidget {
//   const ReflectionCard({
//     Key? key,
//     required this.reflection,
//     required this.deleteAction,
//   }) : super(key: key);
//   final Reflection reflection;
//   final Function() deleteAction;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.purple.shade300,
//       child: Slidable(
//         actionPane: SlidableDrawerActionPane(),
//         secondaryActions: [
//           IconSlideAction(
//             caption: 'Delete',
//             color: Colors.purple[600],
//             icon: Icons.delete,
//             onTap: deleteAction,
//           ),
//         ],
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               reflection.title,
//               style: const TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
