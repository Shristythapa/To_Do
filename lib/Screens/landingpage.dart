import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:time_me/Screens/sign.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyLandingPage();
    // return MaterialApp(
    //   theme: ThemeData(
    //     fontFamily: 'roboto',
    //   ),
    //   debugShowCheckedModeBanner: false,
    //   home: MyLandingPage(),
    // );
  }
}

class MyLandingPage extends StatefulWidget {
  const MyLandingPage({super.key});

  @override
  State<MyLandingPage> createState() => _MyLandingPageState();
}

class _MyLandingPageState extends State<MyLandingPage> {
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
            margin:EdgeInsets.symmetric(vertical: deviceHeight/100*45,horizontal: deviceWidth/100*30),
            
            child: 
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth:400,

                ),
                ///padding: EdgeInsets.only(top: deviceHeight/100*40),
             // margin:EdgeInsets.only(top: deviceHeight/100*5),
               
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6D3F83),
                      foregroundColor: Colors.white,
                       padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
                      ),
                      
                  onPressed: () {
                  //   Navigator.of(context).pop();
                  //  Navigator.push(context,Ma)
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
