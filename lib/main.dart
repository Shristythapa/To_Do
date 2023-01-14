import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:time_me/Screens/dashboard.dart';
import 'package:time_me/Screens/login.dart';
import 'package:time_me/Screens/sign.dart';
import 'package:time_me/viewModel/auth_view_model.dart';
import 'package:time_me/viewModel/global_ui_model_view.dart';
import 'Screens/landingpage.dart';


Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: FirebaseOptions(
    //   apiKey: "AIzaSyDZopgwT3FXAHhsTs2c78yk-dw92lnnEK8",
    //   appId: "1:350617005648:web:64921c07aa521069b4ab55",
    //   messagingSenderId: "350617005648",
    //   projectId: "ToDo",
    // ),
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MyApp(),
  ));
}

//ThemeManager _themeManager = ThemeManager();


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider (create: (_) => GlobalUIViewModel()),
        ChangeNotifierProvider (create: (_) => AuthViewModel()),
      ],
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
          child: Image.asset("images/loader.gif", height: 100, width: 100,),
        ),
        child: Consumer<GlobalUIViewModel>(
          builder: (context, loader, child) {
            if(loader.isLoading){
              context.loaderOverlay.show();
            }else{
              context.loaderOverlay.hide();
            }
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: Colors.blue,
              ),
              initialRoute: "/splash",
              routes: {
                "/login": (BuildContext context)=>LogIn(),
                "/splash": (BuildContext context)=>MyLandingPage(),
                "/register": (BuildContext context)=>mySign(),
                "/dashboard": (BuildContext context)=>Dashboard(),
              },
            );
          }
        ),
      ),
    );
  }
}
