import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:to_do/Screens/tasks/task_list.dart';
import 'package:to_do/repo/auth_repo.dart';
import 'package:to_do/viewModel/auth_view_model.dart';

import '../../models/user_model.dart';
import '../../viewModel/global_ui_model_view.dart';

class Setting extends StatefulWidget {
 

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
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
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
           
               FutureBuilder(
              future: AuthRepository().downoladUrl(_auth.user!.email),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: CircleAvatar(
                      backgroundColor: Color(0xff7889B5),
                      radius: 95,
                      child: CircleAvatar(
                        radius: 90,
                        backgroundImage: NetworkImage(snapshot.data!)
                      ),
                    ),
                  );
                }else{
                  return Center(
              child: CircleAvatar(
                backgroundColor: Color(0xFF6D3F83),
                radius: 95,
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/dummyProfileImage.jfif'),
                  radius: 90,
                ),
              ),
            );
                }
              },
            ),
           FutureBuilder<DocumentSnapshot<UserModel>>(
            future:AuthRepository().getUser(_auth.user!.uid),
            builder:  (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        return  Card(
                margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                color:Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                    
                        Padding(
                        padding: EdgeInsets.only(
                            right: 70, left: 30, bottom: 20, top: 10),
                        child: ListTile(
                          title: Text(
                            "Email",
                            style: TextStyle(
                                backgroundColor: Colors.transparent,
                                fontSize: 20),
                          ),
                          subtitle: Text(
                          _auth.user!.email.toString(),
                            style: TextStyle(
                                backgroundColor: Colors.transparent,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ]));
          
  }),
        
            Card(
              margin: EdgeInsets.only(right: 20, left: 20, top: 20),
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  logout();
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(right: 70, left: 30, bottom: 25, top: 25),
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
            SizedBox(height: 40,)
          ],
        ));
  }
}
