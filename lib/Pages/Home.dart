import 'package:flutter/material.dart';
import 'Saved.dart';
import 'Search.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';
import '../Provider/State.dart';
import './Widget/GridViewer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  bool isConnected = true;
  var subscribtion;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    subscribtion.cancel();
    super.dispose();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    checkConnection();
    var appState = Provider.of<InitialState>(context);

    return Scaffold(
        backgroundColor: Color(0xff99D6DD),
        body: isConnected
            ? Stack(
                children: <Widget>[
                  Container(
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
                        return GridViewWidget(appState: appState,list: snapshot.data,);
                      },
                    ),
                  ),
                  buildAlign(context) // Menu
                ],
              )
            : Center(
                child: Text("Not connected to the internet"),
              ));
  }


  Align buildAlign(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 200.0,
        margin: EdgeInsets.only(bottom: 30.0),
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.home,
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
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Saved()));
                    },
                    icon: Icon(
                      Icons.bookmark,
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

  void checkConnection() {
    subscribtion = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print(result);
      if (result == ConnectivityResult.none) {
        setState(() {
          isConnected = false;
        });
      } else if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        setState(() {
          isConnected = true;
        });
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}

