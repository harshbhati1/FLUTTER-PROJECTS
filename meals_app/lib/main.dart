import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/Data/categoriesData.dart';
import 'package:meals_app/Screen/categoriesScreen.dart';
import 'package:meals_app/Screen/mealScreen.dart';
import 'package:meals_app/Screen/tabScreen.dart';
import 'package:riverpod/riverpod.dart';

final theme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.latoTextTheme(),
  
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0))

);
void main (){
  runApp(const ProviderScope(child: App()) );

}

class App extends StatelessWidget {
 const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home:  const tabScreen(),
    );
  }
}