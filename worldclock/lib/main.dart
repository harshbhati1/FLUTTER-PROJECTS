import 'package:flutter/material.dart';
import 'package:worldclock/pages/home.dart';
import 'package:worldclock/pages/loading.dart';
import 'package:worldclock/pages/location.dart';

void main(){
  runApp(MaterialApp(
    initialRoute: "/loading",
    routes: {
      "/home":(context) => home(),
      "/loading":(context) => loading(),
      "/location":(context) => location()
    },
  ));
}