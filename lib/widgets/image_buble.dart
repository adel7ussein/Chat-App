import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/message.dart';

class ImageBuble extends StatelessWidget {
  const ImageBuble({ Key? key,
    required this.message}) : super(key: key);
    final MessageResponse message ;


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32)
          ),
          color: kPrimaryColor
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child:  Image.network(message.imageUrl  , errorBuilder: (context, error, stackTrace) => const Text('No image',style: TextStyle(
          color: Colors.white,
        ) ,),),
        ),
      ),
    );
  }
}


class ImageBubleForFriend extends StatelessWidget {
  const ImageBubleForFriend({ Key? key,
    required this.message}) : super(key: key);
    final MessageResponse message ;


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32)
          ),
          color: Color(0xff006D84)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child:  Image.network(message.imageUrl  , errorBuilder: (context, error, stackTrace) => const Text('No image',style: TextStyle(
          color: Colors.white,
        ) ,),),
        ),
      ),
    );
  }
}