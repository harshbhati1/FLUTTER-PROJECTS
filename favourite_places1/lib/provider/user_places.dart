import 'dart:io';


import 'package:favourite_places1/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';



class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  Future<Database> _getDataBase() async{
  final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(path.join(dbPath,'places.db'),onCreate: (db,version){
      return db.execute("CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)");
    },
     version: 1,
    );
    return db;
  }

  Future<void> loadPlaces()async{
    final db = await _getDataBase();
    final data = await db.query('user_places');
    final places = data.map((row)=> Place(id: row['id'] as String,title: row['title'] as String, image: File(row['image']  as String), 
    location: PlaceLocation(latitude: row['lat'] as double, longitude: row['lng'] as double, address: row['address'] as String))).toList();
    state = places;
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedimage = await image.copy("${appDir}/${filename}");

    final newPlace = Place(title: title, image:copiedimage, location: location );

    
    state = [newPlace, ...state];
    //storing data into the database
    final db = await _getDataBase();
    db.insert('user_places', {
      'id':newPlace.id,
      'title':newPlace.title,
      'image':newPlace.image.path,
      'lat':newPlace.location.latitude,
      'lng':newPlace.location.longitude,
      'address':newPlace.location.address
    });
  }

}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);