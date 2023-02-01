import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Screens/tasks/task_tile.dart';
import 'package:to_do/services/firebase_services.dart';
import '../../viewModel/auth_view_model.dart';
import '../../viewModel/task_view_model.dart';
import '../settings/user_settings.dart';
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
   bool boxChecked=false;
  
  @override
  void initState() {
    _taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    _authViewModel=Provider.of<AuthViewModel>(context, listen: false);
    _taskViewModel = Provider.of<TaskViewModel>(context,listen: false);
   
    
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(
      builder: (context, taskVM, child) {
        return Scaffold(
          //appbar
          appBar: AppBar(
            backgroundColor: Color(0xff7889B5),

            //settings
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                 MaterialPageRoute(builder: (context) => Setting()),
                );
              },
              child: Icon(
                Icons.settings,
                color: Color(0xffD8D1E3),
              ),
            ),
            actions: [
               GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                 MaterialPageRoute(builder: (context) => Setting()),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Icon(
                  Icons.notifications,
                  color: Color(0xffD8D1E3),
                ),
              ),
            ),
            ],

            //title
            title: Center(
                child: Text("Tasks",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25))),
                        
          ),
            body: ListView(children: [
              ...taskVM.allTask.map((e) => TaskTile(e.status, e.task,e.id))
            ],),
          // body: FutureBuilder<List<Task>>(
          //     future: myTasks,
              
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData &&
          //           snapshot.connectionState == ConnectionState.done) {
          //         return ListView.builder(
          //           itemCount: snapshot.data!.length,
                    
          //           itemBuilder: (context, index) {
          //             return TaskTile(snapshot.data!.elementAt(index).status, snapshot.data!.elementAt(index).task);
                  
          //         });
          //       } else {
          //         return Center(child: CircularProgressIndicator());
          //       }
          //     }),

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
    );
  }
}
