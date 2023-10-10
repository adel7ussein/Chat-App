import 'package:scholar_chat/constants.dart';

class ImageUrl{
  final String imageurl;

  ImageUrl(this.imageurl);
  factory ImageUrl.fromjson(jsonData){
    return ImageUrl(jsonData[kImage]);
  }
}