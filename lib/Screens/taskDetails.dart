import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Screens/tasks/task_list.dart';

import '../models/task_model.dart';
import '../viewModel/auth_view_model.dart';
import '../viewModel/task_view_model.dart';

class TaskDetails extends StatefulWidget {
  bool isChecked;
  late Task task;
  TaskDetails(this.task, this.isChecked);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  late TaskViewModel _taskViewModel;
  late AuthViewModel _authViewModel;

  @override
  void initState() {
    _taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
   

    super.initState();
  }
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const DashBoard()));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
         
              ListTile(
                leading: Checkbox(
                  activeColor: Theme.of(context).primaryColor,
                  checkColor: Colors.white,
                  value: widget.isChecked,
                  onChanged: (_) {
                    final provider =
                        Provider.of<TaskViewModel>(context, listen: false);
                    final isChecked = provider.updateTask(widget.task);
                     Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const DashBoard()));
                  },
                
                ),
                title: Text("Task Status",
                 style: TextStyle(
                                backgroundColor: Colors.transparent,
                                fontSize: 20)),
              ),
             
          
          Card(
               
                margin: EdgeInsets.only(right: 20, left: 20, top: 20),
              //  color: Color.fromARGB(255, 239, 235, 241),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 70, left: 30, bottom: 20, top: 20),
                          child: Text("Task Details",style: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: 70, left: 30, bottom: 20, top: 10),
                        child: ListTile(
                          title: Text(
                            "Title",
                            style: TextStyle(
                                backgroundColor: Colors.transparent,
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            widget.task.task,
                            style: TextStyle(
                                backgroundColor: Colors.transparent,
                                fontSize: 20),
                          ),
                        ),
                      ),
                        Padding(
                        padding: EdgeInsets.only(
                            right: 70, left: 30, bottom: 20, top: 10),
                        child: ListTile(
                          title: Text(
                            "Date",
                            style: TextStyle(
                                backgroundColor: Colors.transparent,
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            widget.task.date,
                            style: TextStyle(
                                backgroundColor: Colors.transparent,
                                fontSize: 20),
                          ),
                        ),
                      ),
                       Padding(
                        padding: EdgeInsets.only(
                            right: 70, left: 30, bottom: 20, top: 10),
                        child: ListTile(
                         title: Text(
                            "Time",
                            style: TextStyle(
                                backgroundColor: Colors.transparent,
                                fontSize: 20, fontWeight:FontWeight.w500),
                          ),
                          subtitle: Text(
                            widget.task.time,
                            style: TextStyle(
                                backgroundColor: Colors.transparent,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ])),

                     SizedBox(height: 40),
          SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              onPressed: (() {
                  _taskViewModel.deleteTask(widget.task.id, widget.task.userId);
               
                        
                          Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const DashBoard()));
                    
              }),
              style: ElevatedButton.styleFrom(
                backgroundColor:Color(0xff7889B5),
                foregroundColor:Colors.white,
              ),
              child: Text('Delete Task',style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w500,
                              ),),
            ),
          ),
           SizedBox(height: 40),
        ],
      ),
    );
  }
}
