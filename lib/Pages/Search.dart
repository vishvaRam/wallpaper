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
                  print(value);
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
                      _controller.clear();
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
    return ListView(
      children: <Widget>[
        Container(
          height: 60.0,
          child: _searchBar(),
          padding: EdgeInsets.only(top: 6.0, left: 8.0, right: 8.0),
        ),
        Container(),
        Container(
          height: 220.0,
          child: _searchByColor(),
        )
      ],
    );
  }

  Widget _searchByColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Colors",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        Container(
          height: 150.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              colorBTN(context, "Red", Colors.red),
              colorBTN(context, "Blue", Colors.blueAccent),
              colorBTN(context, "Green", Colors.green),
              colorBTN(context, "Yellow", Colors.yellow),
              colorBTN(context, "Black", Colors.black),
              colorBTN(context, "White", Colors.white),
            ],
          ),
        )
      ],
    );
  }

  Padding colorBTN(BuildContext context, String title, Color color) {
    var state = Provider.of<InitialState>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, bottom: 20.0, right: 5.0),
      child: Material(
        elevation: 12.0,
        borderRadius: BorderRadius.circular(15.0),
        shadowColor: color,
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: 140.0,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(15.0)),
            ),
            Positioned.fill(
                child: Material(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.white70,
                onTap: () {
                  print(state.baseURL + state.color + title.toLowerCase());
                  state.searchList = [];
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(url: state.baseURL + state.color + title.toLowerCase())));
                },
                child: Container(
                  child: Center(
                      child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 32.0,
                        color: color == Colors.white
                            ? Colors.black
                            : Colors.white),
                  )),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15.0)),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
