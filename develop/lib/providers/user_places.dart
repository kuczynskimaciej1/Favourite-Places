import 'dart:io' show File;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart'
    as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart'as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:develop/models/place.dart';

///Gets a reference to the SQLite database.
///
///A variable [dbPath] stores the received path to the database, 
///obtained using the [sql.getDatabasesPath] funtion.
///
///A variable [db] stores the database. 
///The function [sql.openDatabase] opens the database
///or creates it if it doesn't exist.
///The [path.join] method sets the database file name.
///The [onCreate] attribute defines the schema for the database on creation.
///The [version] attribute sets the database version.
///
///Returns the database instance
Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();

  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
    },
    version: 1,
  );
  return db;
}

///A notifier class extending [StateNotifier] for managing a list of [Place] objects.
class UserPlacesNotifier extends StateNotifier<List<Place>> {
  ///Initializes with an empty list.
  UserPlacesNotifier() : super(const []);

  ///Loads places from the database.
  ///
  ///A [db] variable stores the database instance received from the [_getDatabase] function.
  ///A [data] variable stores an all-row query regarding the [user_places] table.
  ///The query result is converted into a list of [Place] objects.
  ///The final state is updated with the fetched places.
  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data =
        await db.query('user_places');
    final places = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            location: PlaceLocation(
              latitude: row['lat'] as double,
              longitude: row['lng'] as double,
              address: row['address'] as String,
            ),
          ),
        )
        .toList();

    state = places;
  }

  ///Adds a new place to the database and the state.
  ///
  ///The variables [appDir], [filename] and [copiedImage], 
  ///along with the methods assinging values to them,
  ///serve for copying the image file to the app's documents directory.
  ///A [newPlace] variable stores a newly created [Place] object.
  ///A [db] variable and the [_getDatabase] and [db.insert] methods
  ///allow for inserting the new place into the database.
  ///The state is updated by adding the new place to the list.
  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');

    final newPlace =
        Place(title: title, image: copiedImage, location: location);

    final db = await _getDatabase();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
    state = [newPlace, ...state];
  }

  ///Deletes a place from the database and the state.
  ///
  ///The function [db.delete] allows for 
  ///deleting the place with the given ID from the database.
  ///The state is updated by removing the place from the list.
  Future<void> deletePlace(String id) async {
    final db = await _getDatabase();
    await db.delete(
      'user_places',
      where: 'id = ?',
      whereArgs: [id],
    );
    state = state.where((place) => place.id != id).toList();
  }
}

///A provider for state management using [Riverpod].
final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
