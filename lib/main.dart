import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/State.dart';
import 'Pages/Home.dart';

void main() {
  runApp(ChangeNotifierProvider<InitialState>(
      create: (context) => InitialState(), child: Main()));
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color(0xff99D6DD),
            accentColor: Color(0xffE0131F),
            brightness: Brightness.light),
        home: Home());
  }
}
