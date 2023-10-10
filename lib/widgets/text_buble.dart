import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/message.dart';

class MessageText extends StatelessWidget {
  const MessageText({Key? key,
    required this.message}) : super(key: key);
  final MessageResponse message ;


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32)
          ),
          color: kPrimaryColor
        ),
        child:Text(message.message, style: const TextStyle(
          color: Colors.white,
        ))
      ),
    );
  }
}

class MessageTextForFriend extends StatelessWidget {
  const MessageTextForFriend({Key? key,
    required this.message}) : super(key: key);
  final MessageResponse message ;


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32)
          ),
          color: Color(0xff006D84)
        ),
        child:Text(message.message, style: const TextStyle(
          color: Colors.white,
        ))
      ),
    );
  }
}