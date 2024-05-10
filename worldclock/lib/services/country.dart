import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
class Country{
  String name;
  String flag;
  String url;
  bool isDaytime = false;
  String time = "";

  Country({required this.name, required this.flag, required this.url});


  Future<void> getTime() async{
    try{
    Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    Map data = jsonDecode(response.body);

    String datentime = data['datetime'];
    String offset = data['utc_offset'];

   

    DateTime answer = DateTime.parse(datentime);
    answer = answer.add(Duration(hours: int.parse(offset.substring(1,3))));
    answer = answer.add(Duration(minutes: int.parse(offset.substring(4,6))));

    isDaytime = answer.hour>6 && answer.hour<20 ? true:false;
    time = DateFormat.jm().format(answer);}

    catch (e){
      print(e);
      time = "We have got a bug";
    }

  }
}

