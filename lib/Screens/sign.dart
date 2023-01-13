import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:ui';
import 'package:flutter/src/material/material_state.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:time_me/Auth/google_sign_in_dart.dart';
import 'package:time_me/Screens/login.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:time_me/crude/profilePicture.dart';
import 'package:time_me/crude/userCrude.dart';

class Sign extends StatelessWidget {
  const Sign({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mySign(title: 'sign up'),
    );
  }
}

//validation functions

//email

class mySign extends StatefulWidget {
  const mySign({super.key, required this.title});

  final String title;

  @override
  State<mySign> createState() => _mySignUpState();
}

class _mySignUpState extends State<mySign> {
  bool buttonPressed = false;
  String name = '';
  String password = '';
  String email = '';
  bool showPassword = false;

  TextEditingController user_name = new TextEditingController();
  TextEditingController e_mail = new TextEditingController();
  TextEditingController pass_word = new TextEditingController();
  FocusNode myFocusNode = new FocusNode();
  File? image;

  static bool validate(String email,
      [bool allowTopLevelDomains = false, bool allowInternational = true]) {
    // TODO: implement validate
    throw UnimplementedError();
  }

  void databaseReg() {
    late DatabaseReference userRef;

    @override
    void initState() {
      super.initState();
      userRef = FirebaseDatabase.instance.ref().child('USER');
      Map<String, String> user = {
        'username': user_name.text,
        'email': e_mail.text,
        'password': pass_word.text
      };
      userRef.push().set('USER');
    }
  }

  final form = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<int?> regirster() async {
    try {
      final user = (await _auth.createUserWithEmailAndPassword(
              email: e_mail.text, password: pass_word.text))
          .user;

      if (user != null) {
        print("user Created");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 159, 39, 30),
          content: Text("Register sucess"),
        ));
        // Navigator.of(context).pushReplacementNamed("/uploadImage");
        return 1;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return 0;
    }
  }

  Future setImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/loginSignUp.jpg'), fit: BoxFit.cover),
          ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Form(
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                key: form,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: Container(
                    padding: EdgeInsets.all(40),
                    child: Center(
                        child: ListView(
                      children: [
                        InkWell(
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: image != null
                                  ? FileImage(File(image!.path)) as ImageProvider
                                  : AssetImage('images/profile.png'),
                              radius: 80,
                            ),
                          ),
                          onTap: (() {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => bottomSheet(context));
                          }),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: user_name,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "username is required";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(color: Color(0xFF6D3F83)),
                              prefixIcon: Icon(Icons.account_circle,
                                  color: Colors.white),
                              labelText: "username",
                              labelStyle: TextStyle(
                                  fontFamily: 'roboto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: myFocusNode.hasFocus
                                      ? Color.fromARGB(255, 136, 117, 163)
                                      : Color.fromARGB(255, 139, 117, 169)),
                              border: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                          onChanged: (value) => setState(() {
                            name = value;
                          }),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          style: TextStyle(fontSize: 20),
                          controller: e_mail,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Email is invalid";
                            } else if (!value.contains('@gmail.com')) {
                              return 'Email is invalid';
                            } else {
                              return null;
                            }
                          },
                          focusNode: myFocusNode,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(color: Color(0xFF6D3F83)),
                            prefixIcon: Icon(Icons.mail, color: Colors.white),
                            labelText: "email",
                            labelStyle: TextStyle(
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: myFocusNode.hasFocus
                                    ? Color.fromARGB(255, 136, 117, 163)
                                    : Color.fromARGB(255, 139, 117, 169)),
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => setState(() {
                            email = value;
                          }),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          style: TextStyle(fontSize: 20),
                          controller: pass_word,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "password is required";
                            } else if (value.length < 4) {
                              return 'password must be higher than four character';
                            } else {
                              return null;
                            }
                          },
                          obscureText: !showPassword,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            errorStyle: TextStyle(color: Color(0xFF6D3F83)),
                            labelText: "password",
                            labelStyle: TextStyle(
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
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
                                        color:
                                            Color.fromARGB(255, 107, 106, 106)),
                                  ),
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusColor: Color.fromARGB(255, 141, 125, 164),
                          ),
                        ),
                        SizedBox(height: 40),
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: ElevatedButton(
                            onHover: (value) {
                              setState(() {
                                !buttonPressed;
                                ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF6D3F83),
                                    foregroundColor:
                                        Color.fromARGB(255, 146, 114, 174));
                              });
                            },
                            onPressed: (() {
                              buttonPressed = !buttonPressed;
                              if (form.currentState!.validate()) {
                                Future<int?> r = regirster();
                                databaseReg();
                                if (r == 1) {
                                  addUser(user_name: user_name.text,email: e_mail.text,pass_word: pass_word.text,context: context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Login validation Sucess")));
                                }
                              }
                            }),
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 20,
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
                        ElevatedButton.icon(
                          onHover: (value) {
                            setState(() {
                              !buttonPressed;
                              ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF6D3F83),
                                  foregroundColor:
                                      Color.fromARGB(255, 146, 114, 174));
                            });
                          },
                          onPressed: (() {
                            final provider = Provider.of<GoogleSignInProvider>(
                                context,
                                listen: false);
                            provider.googleLogin();
                          }),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 146, 114, 174),
                            foregroundColor: Color.fromARGB(255, 230, 211, 239),
                          ),
                          icon: FaIcon(FontAwesomeIcons.google,
                              color: Colors.grey),
                          label: Text('Sign Up with Google'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Center(
                              child: InkWell(
                            child: Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Color.fromARGB(255, 141, 125, 164),
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(context,  MaterialPageRoute(builder: (context) => const LogIn()));
                            },
                          )),
                        )
                      ],
                    )),
                  ),
                ),
              ))),
    );
  }

  Widget bottomSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        width: double.infinity,
        height: size.height * 0.2,
        child: Column(
          children: [
            Text("Choose Profile Photo",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Column(
                    children: [
                      Icon(Icons.image),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Gallary",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  onTap: () {
                    setImage(ImageSource.gallery);
                  },
                ),
                SizedBox(
                  width: 80,
                ),
                InkWell(
                  child: Column(
                    children: [
                      Icon(Icons.camera),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Camera",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  onTap: (() {
                    setImage(ImageSource.camera);
                  }),
                ),
              ],
            )
          ],
        ));
  }
}
