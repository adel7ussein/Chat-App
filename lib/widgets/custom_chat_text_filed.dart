import 'package:flutter/material.dart';

class CustomChatTextFeild extends StatelessWidget {
  const CustomChatTextFeild(
      {Key? key,
      required this.controller,
      required this.onSubmitted,
      required this.color,
      required this.cameraFunc})
      : super(key: key);
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final Color color;
  final VoidCallback cameraFunc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: controller,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
            hintText: 'Send Message',
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.camera_enhance),
                  onPressed: cameraFunc,
                ), //SizedBox(width: 5), // Add space between icons
                //Icon(Icons.mic),
                //SizedBox(width: 10), // Add space between icons
                IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {},
                ),
                //SizedBox(width: 5), // Add space between icons
              ],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: color))),
      ),
    );
  }
}
