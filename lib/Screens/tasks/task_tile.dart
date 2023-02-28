import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Screens/tasks/taskDetails.dart';
import 'package:to_do/Screens/tasks/task_list.dart';
import 'package:to_do/viewModel/task_view_model.dart';

import '../../models/task_model.dart';

class TaskTile extends StatefulWidget {
   bool isChecked;
  late Task task;
  TaskTile(this.task, this.isChecked);
  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  late TaskViewModel taskViewModel;
  @override
  void initState() {
    
    taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    super.initState();
  }

  void deleteTask(String id, String user) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Are you sure you want to delete"),
        actions: [
          ElevatedButton(
            onPressed: () {
              taskViewModel.deleteTask(id, user).then((value) =>
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Product deleted"))));
              Navigator.of(context).pop();
            },
            child: Text("Delete"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Card(
        elevation: 2,
        child: GestureDetector(
          onTap: (() {
            Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  TaskDetails(widget.task,widget.isChecked)));
          }),
          child: ListTile(
        
              
              leading: Icon(
                 
                  widget.isChecked?Icons.check_box:Icons.panorama_fish_eye,
                  
                ),
              // trailing: GestureDetector(
              //   onTap: (() {
              //     deleteTask(widget.task.id, widget.task.userId);
              //   }),
              //   child: const Icon(
              //     Icons.delete,
              //     color: Colors.red,
              //   ),
              // ),
              title: Text(widget.task.task)),
        ),
      ),
    );
  }
}
