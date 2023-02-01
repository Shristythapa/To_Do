import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:to_do/Screens/tasks/task_list.dart';
import 'package:to_do/viewModel/auth_view_model.dart';

import '../../viewModel/global_ui_model_view.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late GlobalUIViewModel _ui;
  late AuthViewModel _auth;
  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _auth = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  void logout() async {
    _ui.loadState(true);
    try {
      await _auth.logout().then((value) {
        Navigator.of(context).pushReplacementNamed('/login');
      }).catchError((e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
      });
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
    _ui.loadState(false);
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
          title: Text("User Profile"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: Color(0xFF6D3F83),
                radius: 85,
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/dummyProfileImage.jfif'),
                  radius: 80,
                ),
              ),
            ),
            Card(
                margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                color: Color.fromARGB(255, 239, 235, 241),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(
                            right: 70, left: 30, bottom: 0, top: 10),
                        child: ListTile(
                          title: Text(
                            "Shristy Thapa",
                            style: TextStyle(
                                backgroundColor: Colors.transparent,
                                fontSize: 20),
                          ),
                          subtitle: Text(
                            "thapashristy110@gmail.com",
                            style: TextStyle(
                                backgroundColor: Colors.transparent,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ])),
            Card(
              margin: EdgeInsets.only(right: 20, left: 20, top: 20),
              color: Color.fromARGB(255, 239, 235, 241),
              child: InkWell(
                onTap: () {
                  logout();
                },
                child: Padding(
                  padding: EdgeInsets.only(
                            right: 70, left: 30, bottom: 25, top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Log Out",
                        style: TextStyle(
                            backgroundColor: Colors.transparent,
                            color: Color.fromARGB(255, 214, 32, 84),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.logout,
                        color: Color.fromARGB(255, 214, 32, 84),
                      )
                    ],
                  ),
                ),
              ),
            ),
             Card(
              margin: EdgeInsets.only(right: 20, left: 20, top: 20),
              color: Color.fromARGB(255, 239, 235, 241),
              child: InkWell(
                onTap: () {
                  logout();
                },
                child: Padding(
                  padding: EdgeInsets.only(
                            right: 70, left: 30, bottom: 25, top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Log Out",
                        style: TextStyle(
                            backgroundColor: Colors.transparent,
                            color: Color.fromARGB(255, 214, 32, 84),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.logout,
                        color: Color.fromARGB(255, 214, 32, 84),
                      )
                    ],
                  ),
                ),
              ),)
          ],
        ));
  }
}
