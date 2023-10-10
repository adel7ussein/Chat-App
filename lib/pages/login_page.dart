import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';
import 'package:scholar_chat/pages/register_page.dart';

import '../helper/show_bar_bar.dart';


class LoginPage extends StatefulWidget {
      LoginPage({Key? key}) : super(key: key);
  static String id = 'LoginPage' ;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  bool _passwordVisible = true;


  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: formKey ,
            child: ListView(
              children:
              [
                SizedBox(height: 75,),
                Image.asset('assets/images/scholar.png',
                  height: 100,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Scholar Chat",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 75,),
          
                Row(
                  children: [
                    Text("LOGIN",
                      style: TextStyle(fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                CustomFormTextField(onChanged: (data){
                  email =data;
                },
                  hintText: 'Email',),
                const SizedBox(height: 10,),
                CustomFormTextField(onChanged: (data){
                  password =data;
                }
                  ,hintText: 'Password',
                  isObscureText: _passwordVisible,
                  icon: IconButton(onPressed: (){
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  icon: Icon(_passwordVisible ? Icons.visibility_off : Icons.visibility ,color: Colors.white, ),
                  ),
                  ),
                const SizedBox(height: 20,),
                CustomButton(onTap:() async{
                 if (formKey.currentState!.validate()) {
                  isLoading = true;
                  setState(() {
                    
                  });
      try{
      await loginUser();
      //showSnackBar(context,'success process');
      Navigator.pushNamed(context, ChatPage.id, arguments: email);
            
      }on FirebaseAuthException catch(ex){
       if(ex.code == 'user-not-found')
       {
         showSnackBar(context,'No user found for that email');  
       }
      else if(ex.code == 'wrong-password')
      {
          showSnackBar(context,'Wrong password provided for that user');  
            
      }
            
            
                  }catch(ex){
       showSnackBar(context, 'there wae an error');
                  }
            
        isLoading = false;   
        setState(() {
          
        });
    }else
    {
      
    }
                },text : 'LOGIN'),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('don\'t have an account ?',
                      style: TextStyle(color: Colors.white
                      )
                      ,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: Text('  Register',
                        style: TextStyle(
                            color: Color(0xffC7EDE6)
                        ),),
                    )
                  ],
                ),
          
              ],
            ),
          ),
        ),
      ),
    );
  }


   Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
  }
}