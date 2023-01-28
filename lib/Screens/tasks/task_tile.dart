import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TaskTile extends StatefulWidget {
  
   bool isCompleted;
   final String task;
  TaskTile(this.isCompleted,this.task);
  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
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
                      


                        
                        trailing: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        title: Text(widget.task)),
                  ),
                );
  }
}