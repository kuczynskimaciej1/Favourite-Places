import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart'
    as http;

import 'package:develop/screens/map.dart';
import 'package:develop/models/place.dart';

///A [StatefulWidget] for handling location input.
class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});

  ///A callback function called when a location is selected.
  final void Function(PlaceLocation location)
      onSelectLocation;

  ///A funtion for state creation, returns a [_LocationInputState].
  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

///State class for a [LocationInput] widget.
class _LocationInputState extends State<LocationInput> {
  ///The picked location.
  PlaceLocation? _pickedLocation;

  ///Flag to track if the location is being fetched.
  var _isGettingLocation =
      false;

  ///Getter to construct a URL for the location's static map image.
  ///
  ///If no location is picked, an empty string is returned.
  ///A [lat] variable stores the latitude, meanwhile [lng] - longtitide.
  ///An URL string from the static map image is constructed and returned.
  String get locationImage {
    if (_pickedLocation == null) {
      return '';
    }
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyDLcwxUggpPZo8lcbH0TB4Crq5SJjtj4ag';
  }

  ///Saves a place with given latitude and longitude.
  ///
  ///An [url] variable is used for storing the URL construced through the function [Uri.parse] for reverse geocoding.
  ///A [response] variable stores a performed HTTP request by the [http.get] function, with the [url] variable passed as a parameter.
  ///A [resData] variable stores the decoded JSON response by the [json.decode] method.
  ///An [address] variable stores the extracted address.
  ///
  ///A [setState] function sets the state with the new location and turns off the loading indicator.
  Future<void> _savePlace(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyDLcwxUggpPZo8lcbH0TB4Crq5SJjtj4ag');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    final address =
        resData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: latitude,
        longitude: longitude,
        address: address,
      );
      _isGettingLocation = false;
    });
    widget.onSelectLocation(_pickedLocation!);
  }

  ///Get the current location of the device.
  ///
  ///A [Location] instance is called for accessing location data.
  ///A [serviceEnabled] variable checks whether location service is enabled, which is retrieved with the [location.serviceEnabled] and [location.requestService] functions.
  ///A [permissionGranted] variable checks whether permission is granted, which is retrieved with the [location.hasPermission] and [location.requestPermission] functions.
  ///A [locationData] variable stores the location data, which is retrieved with the [location.getLocation] function.
  ///
  ///A [setState] function shows the loading indicator while fetching location.
  ///If location data is not valid, the function returns.
  ///Otherwise, the fetched location is saved using the [_savePlace] function.
  void _getCurrentLocation() async {
    Location location =
        Location();

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
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      return;
    }

    _savePlace(lat, lng);
  }

  ///Allow the user to select a location on the map.
  ///
  ///A [pickedLocation] variable uses the function [Navigator.of().push<LatLng>] to navigate to the [MapScreen] and wait for the location to be picked.
  ///If the location is picked correctly, it is saved using the [_savePlace] function.
  void _selectOnMap() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => const MapScreen(),
      ),
    );
    if (pickedLocation == null) {
      return;
    }
    _savePlace(pickedLocation.latitude, pickedLocation.longitude);
  }

  ///Build the function widget.
  ///
  ///Variables [screenSize] and [screenWidth] store the screen size.
  ///A fraction of the screen width and height is used for sizing in the [containerWidth] and [containerHeight] variables.
  ///When no location is picked or is being fetched, the default [previewContent] is set using the [Container] class.
  ///If the location is picked, its static map image is shown.
  ///If the location is being fetched, a rotating loading spinner is displayed.
  ///
  ///The main widged layout is returned.
  ///The class [SizedBox] adds spacing of given height, with [MainAxisAlignment.spaceAround] spacing the items evenly.
  ///Both buttons are wrapped with [Flexible].
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;

    var containerWidth = screenWidth;
    var containerHeight = screenSize.height * 0.19;

    Widget previewContent = Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        'No location chosen',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
    );

    if (_pickedLocation != null) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: containerWidth,
        height: containerHeight,
      );
    }

    if (_isGettingLocation) {
      previewContent = Container(
        width: containerWidth,
        height: containerHeight,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        SizedBox(
          width: containerWidth,
          height: containerHeight,
          child: previewContent,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: TextButton.icon(
                icon: Icon(Icons.location_on,
                    color: Theme.of(context).colorScheme.primaryContainer),
                label: Text(
                  'Get Current Location',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primaryContainer),
                ),
                onPressed: _getCurrentLocation,
              ),
            ),
            Flexible(
              child: TextButton.icon(
                icon: Icon(Icons.map,
                    color: Theme.of(context).colorScheme.primaryContainer),
                label: Text(
                  'Select on Map',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primaryContainer),
                ),
                onPressed: _selectOnMap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
