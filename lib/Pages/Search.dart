import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qallpaper/Pages/SearchResult.dart';
import 'Home.dart';
import 'Saved.dart';
import 'package:provider/provider.dart';
import '../Provider/State.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with AutomaticKeepAliveClientMixin {
  bool showRecent = true;

  @override
  void initState() {
    super.initState();
  }

  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff99D6DD),
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              child: buildSearchArea(),
            ),
            buildAlign(context)
          ],
        ));
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

  Widget _searchBar() {
    var appState = Provider.of<InitialState>(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          border: Border.all(color: Theme.of(context).accentColor, width: 2.0)),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 7,
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.left,
                obscureText: false,
                style: TextStyle(fontSize: 22.0),
                onChanged: (value) {
                  appState.setInputText(value);
                },
                onSubmitted: (text) {
                  if (text.isNotEmpty) {

                    appState.searchList = [];
                    appState.list = [];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultPage(
                                  url: appState.baseURL +
                                      appState.query +
                                      appState.inputText,
                                )));
                    appState.addTextToList();
                    _controller.clear();
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Search for images',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: InputBorder.none),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.search, size: 24.0),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {

                        appState.searchList = [];
                        appState.list = [];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultPage(
                                  url: appState.baseURL +
                                      appState.query +
                                      appState.inputText,
                                )));
                        appState.addTextToList();
                        _controller.clear();
                      }
                    },
                    splashColor: Theme.of(context).accentColor,
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSearchArea() {
    var appState = Provider.of<InitialState>(context);
    List<String> reversed = List<String>();

    if (appState.recent.length == 0) {
      setState(() {
        showRecent = false;
      });
    } else {
      setState(() {
        showRecent = true;
      });
      if(appState.recent.length<5){
        for(int i = 0; i<appState.recent.length;i++){
          reversed.add(appState.recent[i]);
        }
      }else{
        for(int i = 0; i<4;i++){
          reversed.add(appState.recent[i]);
        }
      }
    }


    return ListView(
      children: <Widget>[
        Container(
          height: 60.0,
          child: _searchBar(),
          padding: EdgeInsets.only(top: 6.0, left: 8.0, right: 8.0),
        ),
        showRecent == true
            ? Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Recent",style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87),),
                        IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              appState.recent = [];
                              setState(() {
                                showRecent = false;
                              });
                            })
                      ],
                    ),
                  ),
                  Column(
                    children: reversed.map((data){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                        child: Container(
                          width: double.infinity,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: (){
                                  appState.searchList = [];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ResultPage(
                                            url: appState.baseURL +
                                                appState.query +
                                                data,
                                          )));
                              },
                              splashColor: Theme.of(context).accentColor,
                              child: Text(data,style: TextStyle(fontSize: 20.0),),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              )
            : Container(),
//        Container(
//          height: 220.0,
//          child: _searchByColor(),
//        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Category",
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87),
            ),
          ),
        ),
        Container(height: 750, child: gridView())
      ],
    );
  }

  Widget gridView() {
    String assets = "Assets/";
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      children: <Widget>[
        catagerys("Animals", assets + "animals.jpg"),
        catagerys("Fruits", assets + "fruits.jpg"),
        catagerys("Space", assets + "space.jpg"),
        catagerys("Education", assets + "education.jpg"),
        catagerys("Nature", assets + "nature.jpg"),
        catagerys("Flowers", assets + "flowers.jpg"),
        catagerys("Models", assets + "model.jpg"),
        catagerys("People", assets + "people.jpg"),
        catagerys("Sports", assets + "sports.jpg"),
        catagerys("Cars", assets + "cars.jpg"),
        catagerys("Bikes", assets + "bikes.jpg"),
        catagerys("Mountains", assets + "mountain.jpg"),
        catagerys("Butterflies", assets + "butterfly.jpg"),
        catagerys("Music", assets + "music.jpg"),
        catagerys("Cities", assets + "cities.jpg"),
//        catagerys("Baby", "https://pixabay.com/get/55e9d5464f57b108f5d084609629367b1039d7ec534c704c7d2b7bdd934ecd50_1280.jpg"),
//        catagerys("Dogs",  "https://pixabay.com/get/55e2d2444e53aa14f6da8c7dda79367f103ad8ec5a516c4870277fd49e49c35cba_1280.jpg"),
      ],
    );
  }

  Widget catagerys(String title, String url) {
    var state = Provider.of<InitialState>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Material(
        elevation: 8.0,
        borderRadius: BorderRadius.circular(15.0),
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
            ),
            Positioned.fill(
                child: Material(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.white70,
                onTap: () {
                  state.searchList = [];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultPage(
                              url: state.baseURL +
                                  state.query +
                                  title.toLowerCase())));
                },
                child: Container(
                  child: Center(
                      child: Text(
                    title,
                    style: TextStyle(fontSize: 22.0, color: Colors.white),
                  )),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(15.0)),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

//  Widget _searchByColor() {
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: <Widget>[
//        Padding(
//          padding: const EdgeInsets.all(10.0),
//          child: Text(
//            "Colors",
//            textAlign: TextAlign.start,
//            style: TextStyle(fontSize: 24.0),
//          ),
//        ),
//        Container(
//          height: 150.0,
//          child: ListView(
//            scrollDirection: Axis.horizontal,
//            children: <Widget>[
//              colorBTN(context, "Red", Colors.red),
//              colorBTN(context, "Blue", Colors.blueAccent),
//              colorBTN(context, "Green", Colors.green),
//              colorBTN(context, "Yellow", Colors.yellow),
//              colorBTN(context, "Black", Colors.black),
//              colorBTN(context, "White", Colors.white),
//            ],
//          ),
//        )
//      ],
//    );
//  }

//  Padding colorBTN(BuildContext context, String title, Color color) {
//    var state = Provider.of<InitialState>(context, listen: false);
//    return Padding(
//      padding: const EdgeInsets.only(left: 15.0, bottom: 20.0, right: 5.0),
//      child: Material(
//        elevation: 8.0,
//        borderRadius: BorderRadius.circular(15.0),
//        shadowColor: color,
//        child: Stack(
//          children: <Widget>[
//            Container(
//              height: MediaQuery.of(context).size.height,
//              width: 140.0,
//              decoration: BoxDecoration(
//                  color: color, borderRadius: BorderRadius.circular(15.0)),
//            ),
//            Positioned.fill(
//                child: Material(
//              borderRadius: BorderRadius.circular(15.0),
//              color: Colors.transparent,
//              child: InkWell(
//                splashColor: Colors.white70,
//                onTap: () {
//                  state.searchList = [];
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => ResultPage(
//                              url: state.baseURL +
//
//                                  title.toLowerCase())));
//                },
//                child: Container(
//                  child: Center(
//                      child: Text(
//                    title,
//                    style: TextStyle(
//                        fontSize: 32.0,
//                        color: color == Colors.white
//                            ? Colors.black
//                            : Colors.white),
//                  )),
//                  decoration: BoxDecoration(
//                      color: Colors.black12,
//                      borderRadius: BorderRadius.circular(15.0)),
//                ),
//              ),
//            )),
//          ],
//        ),
//      ),
//    );
//  }

  @override
  bool get wantKeepAlive => true;
}
