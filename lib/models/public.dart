import 'package:scholar_chat/constants.dart';

class PublicMessage{
   String message;
   String imageurl;

  PublicMessage(this.message, this.imageurl);
  
  factory PublicMessage.fromjson(jsonData)
  {
    return PublicMessage(jsonData[kMessage], jsonData[kImage]);
  }
}