
class MessageResponse{
 late  String message;
  late  String imageUrl;
  late String recordUrl;
  late String id;

  MessageResponse( this.message , this.imageUrl, this.recordUrl);
  
   MessageResponse.fromjson(dynamic jsonData)
  {
    message = jsonData['message'] ?? '';
    id = jsonData['id'] ?? '';
    imageUrl = jsonData['imageurl']  ?? ''; 
    recordUrl = jsonData['recordurl']  ?? ''; 

  }
}