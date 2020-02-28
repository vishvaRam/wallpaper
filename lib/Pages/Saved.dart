import 'package:flutter/material.dart';
import 'Search.dart';
import 'Home.dart';

class Saved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
            ),
             buildAlign(context)
          ],
        )
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
                        child: IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                        },icon: Icon(Icons.home,size: 35.0,),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Search()));
                        },icon: Icon(Icons.search,size: 35.0,),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(onPressed: (){},icon: Icon(Icons.bookmark,size: 35.0,color: Colors.orange,),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
