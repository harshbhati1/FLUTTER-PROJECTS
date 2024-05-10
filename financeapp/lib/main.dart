import 'package:financeapp/Screens/firstScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main(){

  runApp(const MaterialApp(
    
    home: firstScreen(),

  ));
 
}

// for locking the screen into specific oreintation 
// WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations(
//     [
//       DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
//     ]
//   ).then((value) => runApp(const MaterialApp(
    
//     home: firstScreen(),

//   )));