import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

import '../Model/Model.dart';

class InitialState extends ChangeNotifier{
  String baseURL = "https://pixabay.com/api/?key=15418410-7d179ad362f7065069edabf2e&pretty=true&per_page=200&order=latest&editors_choice=true&image_type=photo";
  String query = "&q=";
  String inputText = "";

  List<Data> list = List<Data>();
  List<Data> searchList = List<Data>();

  List<String> recent = List<String>();

  int count;

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
