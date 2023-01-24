import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(

          child: Text("I am dashboard"),
        ),
        floatingActionButton: FloatingActionButton(onPressed:() {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/settings');
        },),
      ),
    );
  }
}