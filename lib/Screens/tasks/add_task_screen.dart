import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Screens/tasks/task_list.dart';

import 'package:to_do/viewModel/task_view_model.dart';

import '../../models/task_model.dart';
import '../../viewModel/auth_view_model.dart';
import '../../viewModel/global_ui_model_view.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController taskController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();
  DateTime? pickedDate;
  TimeOfDay _time = TimeOfDay.now();

  void _selectDate() async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate: DateTime
            .now(), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      print(
          pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(
          pickedDate!); // format date in required form here we use yyyy-MM-dd that means time is removed
      print(
          formattedDate); //formatted date output using intl package =>  2022-07-04
      //You can format date as per your need

      setState(() {
        dateController.text =
            formattedDate; //set foratted date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
      String formatedTime = _time.format(context);
      setState(() {
        timeController.text = formatedTime;
      });
    }
  }

  // database
  late GlobalUIViewModel _ui;
  late AuthViewModel _auth;
  late TaskViewModel _task;

  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _auth = Provider.of<AuthViewModel>(context, listen: false);
    _task = Provider.of<TaskViewModel>(context, listen: false);
    super.initState();
  }

  Future<void> addTask() async {
    _ui.loadState(true);
    var user_id = _auth.user!.uid;
    try {
      await _task
          .addTask(Task(
              userId: user_id,
              task: taskController.text,
              date: dateController.text,
              time: timeController.text,
              status: 0))
          .then((value) => null)
          .catchError((e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
      });
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
    _ui.loadState(false);
    Navigator.pop(context);
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => const DashBoard()));
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
        title: Text("Add Task"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: taskController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Task",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintStyle: TextStyle(
                      fontSize: 18,
                      fontFamily: "Lato",
                      fontStyle: FontStyle.italic,
                      color: Colors.grey)), //Input Decoration
              onChanged: (value) {},
            ), //TextField
          ),
          ListTile(
            title: TextFormField(
                controller:
                    dateController, //editing controller of this TextField
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Enter Date" //label text of field
                    ),
                readOnly: true, // when true user cannot edit text
                onTap: () async {
                  _selectDate();
                }),
          ),
          ListTile(
              title: TextFormField(
            controller: timeController, //editing controller of this TextField
            decoration: const InputDecoration(
                icon: Icon(Icons.access_time), //icon of text field
                labelText: "Enter Time" //label text of field
                ),
            readOnly: true,
            onTap: () async {
              _selectTime();
            },
          )),
          Padding(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: (() {
                addTask();

              }),
              child: Text("SAVE"),
            ),
          )
        ],
      ),
    );
  }
}
