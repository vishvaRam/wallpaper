import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/State.dart';
import './GridViewer.dart';

// ignore: must_be_immutable
class Result extends StatelessWidget {
   Result({
    Key key,
    @required this.future
  }) : super(key: key);

  var future;

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<InitialState>(context,listen: false);
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.data.length ==0){
            return Center(
              child: Text("Images not found",style: TextStyle(fontSize: 24.0),),
            );
          }
          return GridViewWidget(
            appState: appState,
            list: snapshot.data,
          );
        },
      ),
    );
  }
}
