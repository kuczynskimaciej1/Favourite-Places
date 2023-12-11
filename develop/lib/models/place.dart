import 'dart:io';
import 'package:uuid/uuid.dart';

///Create a constant instance of [Uuid] for generating unique IDs.
const uuid =
    Uuid();

class PlaceLocation {

  ///Required parameters for the constructor: [latitude], [longtitude] and [address].
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  ///Immutable variable for latitude.
  final double latitude;
  ///Immutable variable for longitude.
  final double longitude;
  ///Immutable variable for address.
  final String address;
}

class Place {
  ///Required parameters for the constructor: [title], [image] and [location].
  ///[ID] is an optional parameter. If it is not provided, a new unique ID is generated using [Uuid].
  Place({
    required this.title,
    required this.image,
    required this.location,
    String? id,
  }) : id = id ??
            uuid.v4();

  ///Immutable variable for ID.
  final String id;
  ///Immutable variable for title.
  final String title;
  ///Immutable variable for the image file.
  final File image;
  ///Immutable variable for location.
  final PlaceLocation location;
}
