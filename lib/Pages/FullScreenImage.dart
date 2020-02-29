import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../Model/Model.dart';

class FullPageImage extends StatelessWidget {
  final String imgURL;
  final Data dataOfImage;
  FullPageImage({this.imgURL,this.dataOfImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Hero(
              tag: imgURL,
              child: CachedNetworkImage(
                imageUrl: imgURL,
              ),
            ),
          )
        ],
      ),
    );
  }
}
