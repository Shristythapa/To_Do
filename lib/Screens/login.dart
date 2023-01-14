import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:time_me/Screens/sign.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String name = '';
  String password = '';
  String email = '';
  bool showPassword = false;
  TextEditingController pass_word = new TextEditingController();
  TextEditingController e_mail = new TextEditingController();
  final form = GlobalKey<FormState>();
  FocusNode myFocusNode = new FocusNode();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> login() async {
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: e_mail.text, password: pass_word.text.toString())
          .then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Login validation Sucess")));
        // Navigator.of(context).pop();
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => const Settings()));
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/loginSignUp.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 844, maxWidth: 390),
            child: Form(
                key: form,
                child: Container(
                  margin: EdgeInsets.all(40),
                  child: Center(
                      child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: ListView(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(top: deviceHeight / 100 * 10),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Color.fromARGB(255, 146, 114, 174),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'roboto',
                                fontSize: 35),
                          ),
                        ),
                        Container(
                          width: deviceWidth / 100 * 70,
                          height: deviceHeight / 100 * 10,
                          margin: EdgeInsets.only(top: 30),
                          child: TextFormField(
                            style: TextStyle(fontSize: 20),
                            controller: e_mail,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Email is required";
                              } else {
                                return null;
                              }
                            },
                            focusNode: myFocusNode,
                            decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.mail, color: Colors.white),
                                labelText: "email",
                                labelStyle: TextStyle(
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: myFocusNode.hasFocus
                                        ? Color.fromARGB(255, 136, 117, 163)
                                        : Color.fromARGB(255, 139, 117, 169)),
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black))),
                            keyboardType: TextInputType.emailAddress,
                            // onChanged: (String? value) => setState(() {
                            //   e_mail = value;
                            // }),
                          ),
                        ),
                        Container(
                          width: deviceWidth / 100 * 70,
                          height: deviceHeight / 100 * 10,
                          margin: EdgeInsets.only(top: 30),
                          child: SizedBox(
                            width: 300,
                            height: 110,
                            child: TextFormField(
                              style: TextStyle(fontSize: 20),
                              controller: pass_word,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "password is required";
                                } else {
                                  return null;
                                }
                              },
                              obscureText: !showPassword,
                              obscuringCharacter: '*',
                              decoration: InputDecoration(
                                labelText: "password",
                                labelStyle: TextStyle(
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: myFocusNode.hasFocus
                                        ? Color.fromARGB(255, 136, 117, 163)
                                        : Color.fromARGB(255, 139, 117, 169)),
                                prefixIcon: Icon(Icons.lock,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                                suffixIcon: showPassword
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            showPassword = !showPassword;
                                          });
                                        },
                                        child: Icon(Icons.remove_red_eye,
                                            color: Colors.white))
                                    : InkWell(
                                        onTap: () {
                                          setState(() {
                                            showPassword = !showPassword;
                                          });
                                        },
                                        child: Icon(Icons.panorama_fish_eye,
                                            color: Color.fromARGB(
                                                255, 107, 106, 106)),
                                      ),
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusColor: Color.fromARGB(255, 141, 125, 164),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 50,
                          width: 100,
                          child: ElevatedButton(
                            onPressed: (() {
                              if (form.currentState!.validate()) {
                                login();
                              }
                            }),
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 146, 114, 174),
                              foregroundColor:
                                  Color.fromARGB(255, 230, 211, 239),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Center(
                              child: InkWell(
                            child: Text(
                              "Don't have an account",
                              style: TextStyle(
                                color: Color.fromARGB(255, 141, 125, 164),
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  mySign()),
                              );
                            },
                          )),
                        )
                      ],
                    ),
                  )),
                )),
          )),
    );
  }
}