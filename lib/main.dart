import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_me/Auth/google_sign_in_dart.dart';
import 'package:time_me/Screens/login.dart';
import 'package:time_me/Screens/sign.dart';
import 'Screens/landingpage.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MyApp(),
  ));
}

//ThemeManager _themeManager = ThemeManager();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: lightTheme,
        // darkTheme: darkTheme,
        // themeMode: _themeManager.themeMode,
        initialRoute: "/home",
        routes: {
          "/home": (BuildContext context) => LandingPage(),
          // "/login": (BuildContext context) => Login(),
          // "/register": (BuildContext context) => Sign(),
          //"/settings": (BuildContext context) => Settings(),
          //"/profile": (BuildContext context) => MyProfile(),
          //"/isLogedIn": (BuildContext context) => MyWidget()
        },
      ));
}
