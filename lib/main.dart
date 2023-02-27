
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:to_do/services/google_sign_in_dart.dart';
import 'package:to_do/utilities/palette.dart';
import 'package:to_do/viewModel/auth_view_model.dart';
import 'package:to_do/viewModel/global_ui_model_view.dart';
import 'package:to_do/viewModel/task_view_model.dart';
import 'Screens/landingpage.dart';
import 'Screens/login.dart';
import 'Screens/settings/user_settings.dart';
import 'Screens/sign.dart';
import 'Screens/tasks/task_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //   apiKey: "AIzaSyDZopgwT3FXAHhsTs2c78yk-dw92lnnEK8",
      //   appId: "1:350617005648:web:64921c07aa521069b4ab55",
      //   messagingSenderId: "3
      // 50617005648",
      //   projectId: "ToDo",
      // ),
      );
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Palette.kToDark),
        debugShowCheckedModeBanner: false,
    home: const MyApp(),
  ));
}

//ThemeManager _themeManager = ThemeManager();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider (create: (_) => GlobalUIViewModel()),
        ChangeNotifierProvider (create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_)=> TaskViewModel()),
        ChangeNotifierProvider(create: (_)=> GoogleSignInProvider())

      ],
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
          child: Image.asset(
            "images/load-loding.gif",
            height: 300,
            width: 300,
          ),
        ),
        child: Consumer<GlobalUIViewModel>(builder: (context, loader, child) {
          if (loader.isLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Palette.kToDark,
             
            ),
            initialRoute: "/splash",
            routes: {
              "/login": (BuildContext context) => LogIn(),
              "/splash": (BuildContext context) => MyLandingPage(),
              "/register": (BuildContext context) => mySign(),
              "/dashboard": (BuildContext context) => DashBoard(),
              "/settings": (BuildContext context) => Setting(),
            },
          );
        }),
      ),
    );
  }
}
