import 'package:flutter/material.dart';
import 'package:worldclock/services/country.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loading extends StatefulWidget {
  const loading({super.key});

  @override
  State<loading> createState() => _loadingState();
}

class _loadingState extends State<loading> {
  void getDatetime() async{
    Country country = Country(name: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
    await country.getTime();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, "/home", arguments: {
      'name':country.name,
      'flag':country.flag,
      'isDaytime':country.isDaytime,
      'time':country.time
    });


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatetime();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: 
        SpinKitRotatingCircle(
  color: Colors.white,
  size: 50.0,
),
      ),
    );
  }
}