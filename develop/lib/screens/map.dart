import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:develop/models/place.dart';

///A [StatefulWidget] class
class MapScreen extends StatefulWidget {
  ///In the constructor, the default location ([latitude], [longitude], [address]) can be overwritten.
  ///The [isSelecting] flag determines if the location can be selected.
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 50.81190281199852,
      longitude: 19.12002303917363,
      address: '',
    ),
    this.isSelecting =
        true,
  });

  ///The location.
  final PlaceLocation location;
  ///Whether selection mode is on.
  final bool isSelecting;

  ///Creates a state for the map.
  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

///A [State<MapScreen>] class.
class _MapScreenState extends State<MapScreen> {
  ///The location picked by the user.
  LatLng? _pickedLocation;

  ///Builds a widget.
  ///
  ///[Scaffold] provides the structure for the screen layout.
  ///The [title] attribute stores a title based on whether location is being picked.
  ///When the "save" button is pressed, the picked location is returned.
  ///
  ///A [GoogleMaps] widget is used to display the map.
  ///The [_pickedLocation] variable is updated when a location on the map is tapped.
  ///The [CameraPosition] object sets the initial position of the camera in Google Maps.
  ///The [zoom] attribute sets the zoom level for the camera.
  ///The [LatLng] class determines the position for the marker.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.isSelecting
              ? 'Pick your Location'
              : 'Your Location'),
          actions: [
            if (widget.isSelecting)
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  Navigator.of(context).pop(
                      _pickedLocation);
                },
              ),
          ]),
      body: GoogleMap(
        onTap: !widget.isSelecting
            ? null
            : (position) {
                setState(() {
                  _pickedLocation =
                      position;
                });
              },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          zoom: 16,
        ),
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                        widget.location.latitude,
                        widget.location.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
