import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Screens/tasks/task_list.dart';
import 'package:to_do/viewModel/task_view_model.dart';

class TaskTile extends StatefulWidget {
  
   bool isCompleted;
   final String task;
   final String id;
  TaskTile(this.isCompleted,this.task, this.id);
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

  void deleteTask(String id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Are you sure you want to delete"),
        actions: [
          ElevatedButton(
            onPressed: () {
             
              taskViewModel.deleteTask(id)
              .then((value)=>
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content:Text("Product deleted"))
              ));
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
                    child: ListTile(

                        // style: ListTileStyle.,
                        leading: widget.isCompleted? InkWell(
                          onTap: () {
                            setState(() {
                              
                            });
                          },
                          child: Icon(Icons.radio_button_unchecked_outlined),
                        ):InkWell(
                          onTap: () {
                            setState(() {
                             widget.isCompleted=!widget.isCompleted;
                            });
                             
                          },
                          child: Icon(Icons.check_box)
                        ),
                      


                        
                        trailing: GestureDetector(
                          onTap:(() {
                            deleteTask(widget.id);
                          }),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        title: Text(widget.task)),
                  ),
                );
  }
}