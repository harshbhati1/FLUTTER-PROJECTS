import 'dart:convert';


import 'package:favourite_places1/models/place.dart';
import 'package:favourite_places1/widgets/maps.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class locationinput extends StatefulWidget {
  const locationinput({required this.addlocation,super.key});
  final void Function(PlaceLocation location) addlocation;

  @override
  State<locationinput> createState() => _locationinputState();
}

class _locationinputState extends State<locationinput> {
  PlaceLocation? _pickedLocation;
  var isGettingLocation = false;

  String get locationImage {
    if (_pickedLocation == null){
      return "";
    }
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=';
  }

  void _getCurrentLocation() async {
    
  Location location = Location();
  bool serviceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;
  

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return;
    }
  }   

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return;
    }
  } 
  setState(() {
    isGettingLocation = true;
  });

  locationData = await location.getLocation();
  final lat = locationData.latitude;
  final lng = locationData.longitude;

  if (lat == null || lng == null){
    return;
  }

 saveLocation(lat, lng);
  
}
Future<void> saveLocation(double lat, double lng) async{
 final url = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyBXoQCJVoVbncc-Y9j8MA5skUQf7L6qRNM");
  final response = await http.get(url);
  final resdata = jsonDecode(response.body);
  final address = resdata['results'][0]['formatted_address'];

  setState(() {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng, address: address);
    isGettingLocation = false;
  });
  widget.addlocation(_pickedLocation!);
}

void _selectOnMap() async{
  final pickedLocation = await Navigator.of(context).push<LatLng>(MaterialPageRoute(
    builder: (ctx) => const MapScreen()));

    if (pickedLocation == null){
      return;
    }
    saveLocation(pickedLocation.latitude, pickedLocation.longitude);
}

  @override
  Widget build(BuildContext context) {
    Widget previewContent =Text("No location choosen yet", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.onSurface
      ),);

      if (_pickedLocation != null){
        previewContent = Image.network(locationImage, fit: BoxFit.cover, width:  double.infinity, height: double.infinity,);
      }

      if (isGettingLocation == true){
        previewContent = const CircularProgressIndicator();
      }
    
    return Column(
      children: [Container(
         decoration: BoxDecoration(
        border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary.withOpacity(0.2))
      ),
      height: 150,
      width: double.infinity,
      alignment: Alignment.center,
      child: previewContent,
      ),
      const SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(onPressed: _getCurrentLocation, icon: const Icon(Icons.location_on), label: const Text("Get current location")),
           TextButton.icon(onPressed: (){}, icon: const Icon(Icons.map), label: const Text("Select on map")),
        ],
      )],
    );
  }
}
