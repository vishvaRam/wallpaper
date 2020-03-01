import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../Model/Model.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:url_launcher/url_launcher.dart';

class FullPageImage extends StatefulWidget {
  final String imgURL;
  final Data dataOfImage;
  FullPageImage({this.imgURL, this.dataOfImage});

  @override
  _FullPageImageState createState() => _FullPageImageState();
}

class _FullPageImageState extends State<FullPageImage> {
  double imageAlignment = 0;
  double containeAlignment = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipeDetector(

        onSwipeUp: () {
          _setVisible();
        },
        onSwipeDown: () {
          _setNotVisible();
        },

        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Stack(
            children: <Widget>[
              // Image
              AnimatedAlign(
                duration: Duration(milliseconds: 150),
                alignment: Alignment(0, imageAlignment),
                child: Hero(
                  tag: widget.imgURL,
                  child: GestureDetector(
                    onTap: () {
                      _setNotVisible();
                    },
                    child: CachedNetworkImage(
                      imageUrl: widget.imgURL,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              // Button
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: (){
                        _setVisible();
                      },
                      icon: Icon(Icons.arrow_upward,color: Colors.white,),
                    ),
                  ),
                ),
              ),
              // Container
              AnimatedAlign(
                duration: Duration(milliseconds: 200),
                alignment: Alignment(0, containeAlignment),
                child: Container(
                  height: 420.0,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 10.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURL();
                          },
                          child: Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    child: ClipRRect(
                                      child: widget.dataOfImage.userImageURL == ""
                                          ? Image.asset(
                                              "Assets/avatar.png",
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              widget.dataOfImage.userImageURL,
                                              fit: BoxFit.cover,
                                            ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30.0)),
                                    ),
                                    radius: 25.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.dataOfImage.user,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    String url = widget.dataOfImage.pageURL;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _setVisible(){
    setState(() {
      imageAlignment = -0.5;
      containeAlignment = 1.5;
    });
  }
  _setNotVisible(){
    setState(() {
      imageAlignment = 0;
      containeAlignment = 5;
    });
  }
}
