import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qallpaper/Pages/Widget/ResultPage.dart';
import '../Provider/State.dart';
import 'Home.dart';
import 'Saved.dart';


class ResultPage extends StatefulWidget {
  final String url;
  ResultPage({@required this.url});
  @override
  _ResultPageState createState() => _ResultPageState();
}


class _ResultPageState extends State<ResultPage> {

  @override
  void dispose() {
    var appState = Provider.of<InitialState>(context);
    appState.searchList = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<InitialState>(context);
    return Scaffold(
      backgroundColor: Color(0xff99D6DD),
      body: Stack(
        children: <Widget>[
          Result(url: widget.url,function: appState.getSearchImages,),
          buildAlign(context)
        ],
      ),
    );
  }

  Align buildAlign(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 200,
        margin: EdgeInsets.only(bottom: 15.0),
        decoration: BoxDecoration(
          color: Colors.white12,
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      size: 35.0,
                      color: Color(0xffE0131F),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Saved()));
                    },
                    icon: Icon(
                      Icons.favorite_border,
                      size: 35.0,
                      color: Colors.black38,
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
