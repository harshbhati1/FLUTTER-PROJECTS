import 'package:flutter/material.dart';
import 'package:worldclock/services/country.dart';

class location extends StatefulWidget {
  const location({super.key});

  @override
  State<location> createState() => _locationState();
}

class _locationState extends State<location> {
  List <Country> values = 
   [
	    Country(url: 'Europe/London', name: 'London', flag: 'uk.png'),
	    Country(url: 'Europe/Athens', name: 'Athens', flag: 'greece.png'),
	    Country(url: 'Africa/Cairo', name: 'Cairo', flag: 'egypt.png'),
	    Country(url: 'Africa/Nairobi', name: 'Nairobi', flag: 'kenya.png'),
	    Country(url: 'America/Chicago', name: 'Chicago', flag: 'us.png'),
	    Country(url: 'America/New_York', name: 'New York', flag: 'us.png'),
	    Country(url: 'Asia/Seoul', name: 'Seoul', flag: 'south_korea.png'),
	    Country(url: 'Asia/Jakarta', name: 'Jakarta', flag: 'indonesia.png'),
	  ];

    void updateTime(index) async{
      Country country = values[index];
      await country.getTime();
      Navigator.pop(context,{
         'name':country.name,
      'flag':country.flag,
      'isDaytime':country.isDaytime,
      'time':country.time

      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: values.length,
        itemBuilder: (context,index){
          return Card(
            child: ListTile(
              onTap: (){
                updateTime(index);
              },
              title: Text(values[index].name),
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/${values[index].flag}'),

              ),
            ),

          );

      }),
    );
  }
}