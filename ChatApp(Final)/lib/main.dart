import 'package:chatapp1/screens/auth.dart';
import 'package:chatapp1/screens/chat.dart';
import 'package:chatapp1/screens/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 17, 177)),
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (ctx, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return const splashScreen();
        }
        if (snapshot.hasData){
          return const ChatScreen();
        } else{
          return const AuthScreenState();
        }
      }),
    );
  }
}