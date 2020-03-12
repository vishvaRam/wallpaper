import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/State.dart';
import './GridViewer.dart';

class Result extends StatelessWidget {
  const Result({
    Key key,
    @required this.url,
    @required this.function
  }) : super(key: key);

  final String url;
  final Function function;


  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<InitialState>(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: FutureBuilder(
        future: function(url),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
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
