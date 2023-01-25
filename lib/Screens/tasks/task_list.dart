import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/services/firebase_services.dart';
import '../../viewModel/auth_view_model.dart';
import '../../viewModel/task_view_model.dart';
import 'add_task_screen.dart';
import '../../models/task_model.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late TaskViewModel _taskViewModel;
  late AuthViewModel _authViewModel;
  late Future<List<Task>> myTasks;
  @override
  void initState() {
    _taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    _authViewModel=Provider.of<AuthViewModel>(context, listen: false);
    myTasks=_taskViewModel.getTask(_authViewModel.user!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        backgroundColor: Color(0xff7889B5),

        //settings
        leading: GestureDetector(
          onTap: () {
            // Navigator.pop(context);
            // Navigator.push(
            //   context,
            //  // MaterialPageRoute(builder: (context) => Settings()),
            // );
          },
          child: Icon(
            Icons.settings,
            color: Color(0xffD8D1E3),
          ),
        ),

        //title
        title: Center(
            child: Text("Tasks",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25))),
      ),
      body: FutureBuilder<List<Task>>(
          future: myTasks,
          
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
              
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  child: Card(
                    elevation: 2,
                    child: ListTile(

                        // style: ListTileStyle.,
                        leading: const Icon(Icons.check_box),


                        
                        trailing: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        title: Text(snapshot.data!.elementAt(index).task)),
                  ),
                );
              });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff7889B5),
        onPressed: (() {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTask()));
        }),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
