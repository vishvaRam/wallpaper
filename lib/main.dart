import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/State.dart';
import 'Pages/Home.dart';
//import 'Pages/Saved.dart';
//import 'Pages/Search.dart';

void main() {
  runApp(
      ChangeNotifierProvider<InitState>(
      create: (context) => InitState(), child: Main()));
}


class Main  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Home()
    );
  }
}

