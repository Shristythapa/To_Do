import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Screens/login.dart';

import '../viewModel/auth_view_model.dart';
import '../viewModel/global_ui_model_view.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
 
  TextEditingController e_mail = new TextEditingController();
  FocusNode myFocusNode = new FocusNode();

  final form = GlobalKey<FormState>();
   void resetPassword() async {
    _ui.loadState(true);
    try {
      await _auth.resetPassword(e_mail.text).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password reset link has been sent to your email.")));
        Navigator.pop(context);
         Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  LogIn()),
                              );
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
      });
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
    }
    _ui.loadState(false);
  }

  late GlobalUIViewModel _ui;
  late AuthViewModel _auth;
  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _auth = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
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
        appBar: AppBar(
            backgroundColor: Color(0xff7889B5),

            //settings
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                 MaterialPageRoute(builder: (context) => LogIn()),
                );
              },
              child: Icon(
                Icons.arrow_back,
                color: Color(0xffD8D1E3),
              ),
            ),
           

            //title
           
                        
          ),
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
                            "Forgot Password",
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
                       
                        SizedBox(
                          height: 40,
                        ),
                       
                         SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: 100,
                          child: ElevatedButton(
                            onPressed: (() {
                              if (form.currentState!.validate()) {
                               resetPassword();
                              }
                            }),
                            child: Text(
                              "Reset Password",
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
                       
                      ],
                    ),
                  )),
                )),
          )),
    );
  }
}