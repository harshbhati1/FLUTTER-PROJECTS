import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Map data = {};
  @override

 
  Widget build(BuildContext context) {
     data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map; 
     print(data);
     String img = data['isDaytime'] ? "day1.jpg": "night1.jpg";
    return Scaffold(
body: SafeArea(child: Container(
  decoration: BoxDecoration(
    image: DecorationImage(image: AssetImage('assets/$img'), fit: BoxFit.cover)
  ),
child: Padding(
  padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
  child: Center(
    child: Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/${data['flag']}'),
          radius: 60.0,
        ),
        Text(data['name'], style: TextStyle(fontSize: 50.0, color: Colors.white),),
        Text(data['time'], style: TextStyle(fontSize: 40.0, color: Colors.white),),
        ElevatedButton.icon(onPressed: () async{
          dynamic result = await Navigator.pushNamed(context, "/location");
          setState(() { data = {
              'time': result['time'],
                      'name':  result['name'],
                      'flag': result['flag'],
                      'isDaytime':result['isDaytime'],
          };});
        }, icon: Icon(Icons.edit_location), label: Text("Edit Location"),)
        
      ],
    ),
  ),
)
,)),
    );
  }
}