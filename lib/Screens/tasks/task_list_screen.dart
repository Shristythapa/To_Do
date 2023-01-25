
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:to_do/services/firebase_services.dart';
// import '../../viewModel/task_view_model.dart';
// import 'add_task_screen.dart';
// import '../../models/task_model.dart';

// class DashBoard extends StatefulWidget {
//   const DashBoard({super.key});

//   @override
//   State<DashBoard> createState() => _DashBoardState();
// }

// class _DashBoardState extends State<DashBoard> {
//   final List<String> MONTHS = [
//     "Jan",
//     "Feb",
//     "Mar",
//     "Apr",
//     "May",
//     "Jun",
//     "Jul",
//     "Aug",
//     "Sep",
//     "Oct",
//     "Nov",
//     "Dec"
//   ];
//   int index = 0;

//   DateTime dateInput = DateTime.now();
//   //DateTime now = DateTime(dateInput.year,dateInput.month,dateInput.day);
//   late TaskViewModel _taskViewModel;
//   @override
//   void initState() {
//     _taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
//     _taskViewModel.getTasks();

//     super.initState();
//   }

//   Stream<int> generateNumbers = (() async* {
//     await Future<void>.delayed(Duration(seconds: 2));

//     for (int i = 1; i <= 10; i++) {
//       await Future<void>.delayed(Duration(seconds: 1));
//       yield i;
//     }
//   })();
//   List lis = [1, 2, 3];
//   @override
//   Widget build(BuildContext context) {
//     var tasks = context.watch<TaskViewModel>().tasks;
//     return Scaffold(
//       //appbar
//       appBar: AppBar(
//           backgroundColor: Color(0xff7889B5),

//           //settings
//           leading: GestureDetector(
//             onTap: () {
//               // Navigator.pop(context);
//               // Navigator.push(
//               //   context,
//               //  // MaterialPageRoute(builder: (context) => Settings()),
//               // );
//             },
//             child: Icon(
//               Icons.settings,
//               color: Color(0xffD8D1E3),
//             ),
//           ),

//           //title
//           title: Center(
//               child: Text("Tasks",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 25))),

//           //notification
//           actions: <Widget>[
//             Padding(
//               padding: EdgeInsets.only(right: 20.0),
//               child: GestureDetector(
//                 onTap: (() {}),
//                 child: Icon(
//                   Icons.notifications,
//                   color: Color(0xffD8D1E3),
//                 ),
//               ),
//             )
//           ]),

//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           SizedBox(
//             height: 20,
//           ),
//           //datepicker
//           GestureDetector(
//               onTap: (() async {
//                 DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate: dateInput,
//                     firstDate:
//                         DateTime.now(), //- not to allow to choose before today.
//                     lastDate: DateTime(2100));

//                 if (pickedDate == null) {
//                   return;
//                 } else {
//                   setState(() {
//                     dateInput = pickedDate;
//                   });
//                 }
//               }),
//               child: Container(
//                 padding: EdgeInsets.all(5),
//                 margin: EdgeInsets.all(10),
//                 height: 50,
//                 width: MediaQuery.of(context).size.width * 0.6,
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 255, 255, 255),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 1,
//                       blurRadius: 2,
//                       offset: Offset(0, 3), // changes position of shadow
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     // Text("Date : ", style: TextStyle(
//                     //         color: Colors.black,
//                     //         fontWeight: FontWeight.normal,
//                     //         fontSize: 25),),
//                     Center(
//                       child: Text(
//                         "  ${MONTHS[dateInput.month - 1]}  ${dateInput.day} , ${dateInput.year}",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.normal,
//                             fontSize: 25),
//                       ),
//                     ),
//                     Icon(
//                       Icons.arrow_drop_down_outlined,
//                       size: 30,
//                       color: Colors.black,
//                     )
//                   ],
//                 ),
//               )),
//           //datepicker

//           Container(
//             // child: StreamBuilder<int>(
//             //   stream: generateNumbers,
//             //   builder: (
//             //     BuildContext context,
//             //     AsyncSnapshot<int> snapshot,
//             //   ) {
//             //    if(snapshot.hasError) return Text("Error to load data");
//             // child: Expanded(
//             //     child: ListView.builder(
//             //         itemCount: lis.length,
//             //         itemBuilder: (BuildContext context, int index) {
//             //           return Container(
//             //             margin:
//             //                 EdgeInsets.symmetric(vertical: 5, horizontal: 0),
//             //             child: Card(
//             //               elevation: 2,
//             //               child: ListTile(

//             //                   // style: ListTileStyle.,
//             //                   leading: const Icon(Icons.check_box),
//             //                   trailing: const Icon(
//             //                     Icons.delete,
//             //                     color: Colors.red,
//             //                   ),
//             //                   title: Text("List item ${lis[index]}")),
//             //             ),
//             //           );
//             //         }))
//             // },
//             //),

//             //
//             child: StreamBuilder(
//                 stream: FirebaseService.db.collection("tasks").snapshots(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.hasData) {
//                     return ListView(
//                       children:
//                           snapshot.data!.docs.map((DocumentSnapshot document) {
//                         Map<String, dynamic> data =
//                             document.data()! as Map<String, dynamic>;
//                             return ListTile(
//                                  leading: const Icon(Icons.check_box),
//                                  trailing: const Icon(
//                                 Icons.delete,
//                                 color: Colors.red,
//                               ),
//                               title: data["task"],
//                             ); 
//                       }).toList(),
//                     );
//                   } else if (snapshot.hasError) {
//                     return Center(
//                       child: Text("errror"),
//                     );
//                   }
//                   return Center(child: Text("No Task Added"));
//                 }),
//           )
//         ],
//       ),

//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Color(0xff7889B5),
//         onPressed: (() {
//           Navigator.pop(context);
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const AddTask()));
//         }),
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
