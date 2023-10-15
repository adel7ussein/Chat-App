import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({this.hintText,this.onChanged,
  this.icon, this.isObscureText =false});
  String ? hintText;
  Function(String)? onChanged;
  String? fieldMessage;
  Widget? icon;
  bool isObscureText;
  @override
  Widget build(BuildContext context) {
    return   TextFormField(
      /*validator: (data) {
        if(data!.isEmpty){
          return 'field is required';
        }
      }*/
      onChanged: onChanged ,
      obscureText: isObscureText ,
      decoration: InputDecoration(
          suffixIcon: icon,
          hintText: hintText,
          hintStyle: TextStyle(
              color: Colors.white
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          ),

          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          )
      ),
    );
  }
}