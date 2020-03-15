import 'package:flutter/material.dart';
import 'Search.dart';
import 'Home.dart';
import './Widget/GridViewer.dart';
import 'package:provider/provider.dart';
import '../Provider/State.dart';


class Saved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<InitialState>(context);
    return Scaffold(
        backgroundColor: Color(0xff99D6DD),
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              child: appState.fav.length == 0 ? Center(child: Text("Empty",style: TextStyle(fontSize: 24.0),),):GridViewWidget(appState: appState,list: appState.fav,),
            ),
            buildAlign(context)
          ],
        ));
  }

  Align buildAlign(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 200.0,
        margin: EdgeInsets.only(bottom: 15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(60.0),
        ),
        child: Hero(
          tag: "NavBar",
          child: Material(
            borderRadius: BorderRadius.circular(60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    icon: Icon(
                      Icons.home,
                      size: 35.0,
                      color: Colors.black38,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Search()));
                    },
                    icon: Icon(
                      Icons.search,
                      size: 35.0,
                      color: Colors.black38,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
                      size: 35.0,
                      color: Color(0xffE0131F),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
