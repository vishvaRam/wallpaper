import 'package:flutter/material.dart';
import 'Saved.dart';
import 'Search.dart';
import 'package:connectivity/connectivity.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
  Widget build(BuildContext context) {
    subscribtion = Connectivity().onConnectivityChanged.listen((ConnectivityResult result){
      print(result);
      if(result == ConnectivityResult.none){
        setState(() {
          isConnected = false;
        });
      }
      else if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        setState(() {
          isConnected = true;
        });
      }
    });
    return Scaffold(
      body: isConnected ? Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black,
          ),
          buildAlign(context)// Menu
        ],
      ) : Center(child: Text("Not connected to the internet" ),)
    );
  }

  Align buildAlign(BuildContext context) {
    return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 50.0,left: 90.0,right: 90.0),
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
                      child: IconButton(onPressed: (){},icon: Icon(Icons.home,size: 35.0,color: Colors.orange,),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Search()));
                      },icon: Icon(Icons.search,size: 35.0,),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Saved()));
                      },icon: Icon(Icons.bookmark,size: 35.0,),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }

  void checkConnection(){

  }
}
