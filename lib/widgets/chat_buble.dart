import 'package:flutter/material.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/widgets/image_buble.dart';
import 'package:scholar_chat/widgets/record_buble.dart';
import 'package:scholar_chat/widgets/text_buble.dart';

import '../constants.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    Key? key,
    required this.message
  }) : super(key: key);
  final MessageResponse message ;

  @override
  Widget build(BuildContext context) {
    

    if (message.message.isNotEmpty) {
      return MessageText(message: message);
    } 
    else if(message.imageUrl.isNotEmpty) {
      return ImageBuble(message: message);
    } 
    else{
      return RecordBuble(message: message,);
    }

  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({
    Key? key,
    required this.message
  }) : super(key: key);
  final MessageResponse message ;

  @override
  Widget build(BuildContext context) {
    

    if (message.message.isNotEmpty) {
      return MessageTextForFriend(message: message);
    } 
    else if(message.imageUrl.isNotEmpty) {
      return ImageBubleForFriend(message: message);
    } 
    else{
      return RecordBubleForFriend(message: message,);
    }

  }
}