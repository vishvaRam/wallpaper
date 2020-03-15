import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

import '../Model/Model.dart';

class InitialState extends ChangeNotifier{
  String baseURL = "https://pixabay.com/api/?key=15418410-7d179ad362f7065069edabf2e&pretty=true&per_page=200&order=latest&editors_choice=true&image_type=photo";
  String query = "&q=";
  String inputText = "";
  bool isThere = false;

  List<Data> list = List<Data>();
  List<Data> searchList = List<Data>();
  List<Data> fav = List<Data>();
  List<String> recent = List<String>();

  int count;

  void removeFromFav(int item){
    for(int i = 0; i < fav.length ; i++ ){
      if(fav[i].id == item){
        fav.remove(fav[i]);
        print(fav.length);
        print(item);
        for(int i =0 ; i<fav.length;i++){
          print("Item : $i :"+fav[i].largeImageURL);
        }
        break;
      }
    }
  }

  void addToFav(Data data){

   if(fav.length == 0){
     fav.add(data);
     notifyListeners();
     print(fav.length);
     for(int i =0 ; i<fav.length;i++){
       print("Item : $i :"+fav[i].largeImageURL);
     }
   }
   else{
     for(int i =0 ; i<fav.length;i++){
       if(fav[i].id == data.id){
        isThere = true;
        break;
       }
     }
     if(isThere == false){
       fav.add(data);
       print(fav.length);
       notifyListeners();
       for(int i =0 ; i<fav.length;i++){
         print("Item : $i :"+fav[i].largeImageURL);
       }
     }
   }
  }

  void setInputText(String text){
    inputText = text;
    notifyListeners();
  }

  void addTextToList(){
      recent.insert(0, inputText);
      for(var i in recent ){
        print("from List "+i);
      }
      notifyListeners();
  }

  Future<List<Data>> getAllImages(String url) async{
    try{
      http.Response res = await http.get(url);
      if(res.statusCode == 200){
        print("Success");
        var decoded = await jsonDecode(res.body)['hits'];
        for(var i in decoded){
          list.add(Data.fromJson(i));
        }
        print(list.length);
        return list;
      }
    }catch(e){
      print(e);
    }
    return null;
  }

  Future<List<Data>> getSearchImages(String url) async{
    try{
      http.Response res = await http.get(url);
      if(res.statusCode == 200){
        print("Success");
        var decoded = await jsonDecode(res.body)['hits'];
        for(var i in decoded){
          searchList.add(Data.fromJson(i));
        }
        print(searchList.length);
        return searchList;
      }
    }catch(e){
      print(e);
    }
    return null;
  }

}
