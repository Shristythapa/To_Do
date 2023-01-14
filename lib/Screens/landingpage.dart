import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:time_me/Screens/sign.dart';

import '../viewModel/auth_view_model.dart';

class MyLandingPage extends StatefulWidget {
  const MyLandingPage({super.key});

  @override
  State<MyLandingPage> createState() => _MyLandingPageState();
}

class _MyLandingPageState extends State<MyLandingPage> {
  late AuthViewModel _authViewModel;

  // void checkLogin() async{
  //   await Future.delayed(Duration(seconds: 2));
  //   if(_authViewModel.user==null){
  //     Navigator.of(context).pushReplacementNamed("/splash");
  //   }else{
  //     Navigator.of(context).pushReplacementNamed("/dashboard");
  //   }
  // }
  // @override
  // void initState() {
  //   _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
  //   checkLogin();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    print(deviceHeight);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/landing.jpg"), fit: BoxFit.cover),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: deviceWidth,
            height: deviceHeight,
            margin: EdgeInsets.symmetric(
                vertical: deviceHeight / 100 * 45,
                horizontal: deviceWidth / 100 * 30),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 400,
              ),

              ///padding: EdgeInsets.only(top: deviceHeight/100*40),
              // margin:EdgeInsets.only(top: deviceHeight/100*5),

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6D3F83),
                  foregroundColor: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => mySign()),
                  );
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 35),
                ),
              ),
            ),
          )),
    );
  }
}
