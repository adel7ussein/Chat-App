import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/login_page.dart';
import 'package:scholar_chat/pages/register_page.dart';

import 'firebase_options.dart';


void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( 
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatefulWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  State<ScholarChat> createState() => _ScholarChatState();
}
ThemeData _darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.red
);
ThemeData _ligthTheme = ThemeData.light().copyWith(
  primaryColor: Colors.blue
);

class _ScholarChatState extends State<ScholarChat> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: iconBool ? _darkTheme : _ligthTheme ,
      debugShowCheckedModeBanner: false,
      routes: {
        RegisterPage.id : (context) => RegisterPage(),
        ChatPage.id : (context) => ChatPage(),
        LoginPage.id: (context) => LoginPage()
      },
      initialRoute: LoginPage.id,
    );
  }
}
