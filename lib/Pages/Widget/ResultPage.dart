import 'package:flutter/material.dart';
import '../../Provider/State.dart';
import './GridViewer.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({
    Key key,
    @required this.appState,
  }) : super(key: key);

  final InitialState appState;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: FutureBuilder(
        future: appState.getAllImages(appState.baseURL),
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
