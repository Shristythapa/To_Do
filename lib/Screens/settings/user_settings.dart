import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Screens/dashboard.dart';
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

  void logout() async{
    _ui.loadState(true);
    try{
      await _auth.logout().then((value){
        Navigator.of(context).pushReplacementNamed('/login');
      })
          .catchError((e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
      });
    }catch(err){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
    }
    _ui.loadState(false);
  }
  @override
  void initState() {

    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _auth = Provider.of<AuthViewModel>(context, listen: false);
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
                    MaterialPageRoute(builder: (context) => const Dashboard()));
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
                    backgroundImage:
                        AssetImage('images/dummyProfileImage.jfif'),
                    radius: 80,
                  ),
                ),
              ),
            
            Text("Shristy Thapa"),
            Text("thapaShristy110@gmail.com"),
            InkWell(
              onTap: () {
                logout();
              },
              child: Container(
                decoration: BoxDecoration(
                color: Colors.blue
                ),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  
                  Text("Log Out"),
                  Icon(Icons.logout)
                ],
               ),
              ),
            )
          ],
        ));
  }
}
