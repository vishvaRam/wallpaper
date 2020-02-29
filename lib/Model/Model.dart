
class Data {
  int id;
  String pageURL ;
  String tags;
  String largeImageURL;
  int imageWidth;
  int imageHeight;
  int views;
  int downloads;
  int likes;
  String user;
  String userImageURL;
  Data({this.id,this.pageURL,this.tags,this.largeImageURL,this.imageWidth,this.imageHeight,this.views,this.downloads,this.likes,this.user,this.userImageURL});

  factory Data.fromJson(Map<String,dynamic> json){
    return Data(
      id: json['id'],
      pageURL: json['pageURL'],
      tags: json['tags'],
      largeImageURL: json['largeImageURL'],
      imageWidth: json['imageWidth'],
      imageHeight: json['imageHeight'],
      views: json['views'],
      downloads: json['downloads'],
      likes: json['likes'],
      user: json['user'],
      userImageURL: json['userImageURL']
    );
  }
}