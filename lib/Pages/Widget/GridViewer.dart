import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../Model/Model.dart';
import '../../Provider/State.dart';
import '../FullScreenImage.dart';

class GridViewWidget extends StatefulWidget  {
   GridViewWidget({
    Key key,
    @required this.appState,
    this.list,

  }) : super(key: key);
  final List<Data> list;
  final InitialState appState;



  @override
  _GridViewWidgetState createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:10.0,left: 10.0,right: 10.0),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          return Material(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Colors.black12,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: ClipRRect(
                  child: Hero(
                    tag: widget.list[index].largeImageURL,
                    child: CachedNetworkImage(
                      imageUrl: widget.list[index].largeImageURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                )),
                Positioned.fill(
                    child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.white70,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullPageImage(imgURL: widget.list[index].largeImageURL,dataOfImage: widget.list[index],)));
                    },
                  ),
                )),
//                Positioned(
//                  bottom: 8,
//                  right: 8,
//                  child: SizedBox(
//                    height: 45.0,
//                    width: 45.0,
//                    child: FloatingActionButton(
//                      elevation: 4.0,
//                      backgroundColor: Color(0xffEEEEEE),
//                      heroTag: null,
//                      onPressed: () {},
//                      child: Icon(
//                        Icons.add,
//                        color: Color(0xffE0131F),
//                      ),
//                    ),
//                  ),
//                )
              ],
            ),
          );
        },
        staggeredTileBuilder: (int index) =>
            StaggeredTile.count(2, index.isEven ? 2 : 3),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
    );
  }
}
