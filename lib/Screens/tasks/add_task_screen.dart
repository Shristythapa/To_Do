import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';


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

  void _selectDate() async{
    pickedDate = await showDatePicker(
                      context: context,
                       initialDate: DateTime.now(), //get today's date
                      firstDate:DateTime.now(), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  if(pickedDate != null ){
                      print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!); // format date in required form here we use yyyy-MM-dd that means time is removed
                      print(formattedDate); //formatted date output using intl package =>  2022-07-04
                        //You can format date as per your need

                      setState(() {
                         dateController.text = formattedDate; //set foratted date to TextField value. 
                      });
                  }else{
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
      String formatedTime =_time.format(context);
      setState(() {
        timeController.text=formatedTime;
      });
    }
  }
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              // Navigator.pop(context);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const DashBoard()));
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
        controller: dateController, //editing controller of this TextField
          decoration: const InputDecoration( 
                    icon: Icon(Icons.calendar_today), //icon of text field
                   labelText: "Enter Date" //label text of field
            ),
           readOnly: true,  // when true user cannot edit text 
           onTap: () async {
                _selectDate();  
            }
  ),
           
          
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
            },)
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: (() {}),
              child: Text("SAVE"),
            ),
          )
        ],
      ),
    );
  }
}
