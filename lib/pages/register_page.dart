import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/pages/chat_page.dart';

import '../constants.dart';
import '../helper/show_bar_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);
  static String id = 'registerPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _passwordVisible = true;

  String? email;

  String? password;

  bool isLoading = false;

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
            key: formKey,
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
                    Text("REGISTER",
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
                },hintText: 'Password',
                isObscureText: _passwordVisible,
                icon: IconButton(onPressed: (){
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  icon: Icon(_passwordVisible ? Icons.visibility_off : Icons.visibility, color: Colors.white, ),
                  ),
                ),
                const SizedBox(height: 20,),
                CustomButton(onTap: () async{
                 if (formKey.currentState!.validate()) {
                  isLoading = true;
                  setState(() {
                    
                  });
      try{
      await registerUser();
      //showSnackBar(context,'success process');
      Navigator.pushNamed(context, ChatPage.id, arguments: email);
            
      }on FirebaseAuthException catch(ex){
       if(ex.code == 'weak-password')
       {
         showSnackBar(context,'weak-password');  
       }
      else if(ex.code == 'email-already-in-use')
      {
          showSnackBar(context,'email-already-in-use');  
            
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
                },
                    text : 'REGISTER'),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('already have an account?',
                      style: TextStyle(color: Colors.white
                      )
                      ,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text('  Login',
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

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);
  }
}