// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:todo_app/modules/counter/cubit.dart';
// import 'package:todo_app/modules/counter/states.dart';
//
// class CounterScreen extends StatelessWidget {
//   int counter = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     CounterCubit cubit = BlocProvider.of(context);
//     return BlocProvider(
//       create: (BuildContext context) => CounterCubit( ),
//       child: BlocConsumer(
//         listener: (context, state) {
//           if (state is CounterMinusState) {
//             print('minus state ${state.counter}');
//           }
//           if (state is CounterPlusState) {
//             print('plus state ${state.counter}');
//           }
//         },
//         builder: (context, state) {
//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.white,
//               elevation: 0,
//               title: Text(
//                 'Counter',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 30,
//                 ),
//               ),
//             ),
//             body: Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextButton(
//                     child: Text('MINUS'),
//                     onPressed: () {
//                       CounterCubit.get(context).minus();
//                     },
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 5.0,
//                     ),
//                     child: Text(
//                       '${CounterCubit.get(context).counter}',
//                       style: TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       CounterCubit.get(context).plus();
//                       print(counter);
//                     },
//                     child: Text('PLUS'),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
