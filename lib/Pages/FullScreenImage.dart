import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../Model/Model.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:provider/provider.dart';
import '../Provider/State.dart';
import 'package:share/share.dart';

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
  bool isLoading = false;
  bool isThere = false;

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<InitialState>(context);
    return Scaffold(
      body: SwipeDetector(
        onSwipeUp: () {
          _setVisible();
          for(int i = 0 ; i< appState.fav.length ;i++){
            if(widget.dataOfImage.id == appState.fav[i].id){
              setState(() {
                isThere = true;
              });
              break;
            }
          }
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
              imageContainer(),
              // Button
              bottomButton(),
              // Container
              bottomSheetContainer(context),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedAlign imageContainer() {
    return AnimatedAlign(
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
    );
  }

  Widget bottomSheetContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedAlign(
        duration: Duration(milliseconds: 400),
        alignment: Alignment(0, containeAlignment),
        child: Container(
          height: _getheight(MediaQuery.of(context).size.height),
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
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    // Full Container
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      // Notch
                      child: firstRow(context),
                    ),

                    // Details
                    detailContainer(),

                    // Button for Pixabay
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: FlatButton(
                            splashColor: Theme.of(context).primaryColor,
                            onPressed: () {
                              _launchURL(widget.dataOfImage.pageURL);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Download full size",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Material(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            color: Color(0xffa1e6e3),
                            elevation: 6.0,
                            child: FlatButton(
                              splashColor: Theme.of(context).primaryColor,
                              onPressed: () {
                                _launchURL("https://pixabay.com/");
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Pixabay",
                                  style: TextStyle(fontSize: 24.0,color: Colors.black87),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container detailContainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: <Widget>[
          // First ROW
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: rowInDetails(),
          ),
          // Second ROW
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: rowSecond(),
          )
        ],
      ),
    );
  }

  Row rowSecond() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        detailsElement(
            widget.dataOfImage.likes.toString(), Icons.thumb_up, "Likes"),
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.aspect_ratio,
                    size: 24.0,
                    color: Colors.black54,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Size",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: .0),
                child: Text(
                  "${widget.dataOfImage.imageHeight} x ${widget.dataOfImage.imageWidth}",
                  style: TextStyle(fontSize: 18.0),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Row rowInDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        detailsElement(
            widget.dataOfImage.views.toString(), Icons.visibility, "Views"),
        detailsElement(widget.dataOfImage.downloads.toString(),
            Icons.file_download, "Downloads"),
      ],
    );
  }

  Column detailsElement(String detail, IconData icon, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              icon,
              size: 18.0,
              color: Colors.black54,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: .0),
          child: Text(
            detail,
            style: TextStyle(fontSize: 18.0),
          ),
        )
      ],
    );
  }

  Row firstRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // User Details
        userDetails(),
        //Icon Button
        iconBtn(context),
      ],
    );
  }

  Row iconBtn(BuildContext context) {
    var appState = Provider.of<InitialState>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          height: 40.0,
          width: 40,
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            child: RawMaterialButton(
              splashColor: Theme.of(context).primaryColor,
              onPressed: () {
                _imageDownloader(widget.dataOfImage);
              },
              child: isLoading
                  ? Container(
                      height: 20.0,
                      width: 20.0,
                      child: CircularProgressIndicator())
                  : Icon(Icons.file_download),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0))),
            ),
          ),
        ),
        Container(
          height: 40.0,
          width: 40,
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            child: RawMaterialButton(
              splashColor: Theme.of(context).primaryColor,
              onPressed: () {
                Share.share(widget.dataOfImage.pageURL, subject: widget.dataOfImage.user+"");
              },
              child: Icon(Icons.share),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0))),
            ),
          ),
        ),
        Container(
          height: 40.0,
          width: 40,
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            child: RawMaterialButton(
              splashColor: Theme.of(context).accentColor,
              onPressed: () {
                if(isThere){
                  print("Delete");
                  setState(() {
                    isThere = false;
                  });
                  appState.removeFromFav(widget.dataOfImage.id);
                }
                else{
                  setState(() {
                    isThere = true;
                  });
                  appState.addToFav(widget.dataOfImage);
                }
              },
              child: isThere ? Icon(Icons.favorite,color: Colors.redAccent,) :Icon(Icons.favorite_border),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0))),
            ),
          ),
        )
      ],
    );
  }

  GestureDetector userDetails() {
    return GestureDetector(
      onTap: () {
        _launchURL(widget.dataOfImage.pageURL.toString());
      },
      child: Row(
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
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            radius: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.dataOfImage.user,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Align bottomButton() {
    var appState = Provider.of<InitialState>(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        child: Material(
          color: Colors.transparent,
          child: IconButton(
            onPressed: () {
              _setVisible();
              for(int i = 0 ; i< appState.fav.length ;i++){
                if(widget.dataOfImage.id == appState.fav[i].id){
                  setState(() {
                    isThere = true;
                  });
                  break;
                }
              }
            },
            icon: Icon(
              Icons.arrow_upward,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _imageDownloader(Data data) async {
    try {
      setState(() {
        isLoading = true;
      });
      var imageId = await ImageDownloader.downloadImage(data.largeImageURL,
          destination: AndroidDestinationType.directoryPictures
            ..subDirectory("WallE/${data.id}" + ".jpeg"));

      setState(() {
        isLoading = false;
      });
      if (imageId == null) {
        return;
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  _setVisible() {
    setState(() {
      imageAlignment = -0.5;
      containeAlignment = 1.5;
    });
  }

  _setNotVisible() {
    setState(() {
      imageAlignment = 0;
      containeAlignment = 5;
    });
  }

  _getheight(var height){
    if(height <= 700){
      return 380.0;
    }
    else{
      return MediaQuery.of(context).size.height / 2 ;
    }
  }
}
