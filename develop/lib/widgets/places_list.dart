import 'package:flutter/material.dart';
import 'package:develop/widgets/img_box.dart';
import 'package:develop/models/place.dart';

///A stateless widget class.
class PlacesList extends StatelessWidget {
  ///Constructor with required [Places] parameter and an optional key.
  const PlacesList({super.key, required this.places});

  ///An immutable list of [Place] objects.
  final List<Place> places;

  ///Returns a widget based on the current state.
  ///
  ///If the [places] list is empty, a [Center] widget is returned for alignment.
  ///This widget contains a display [Text] indicating that no places are added
  ///with [style] using the current theme context.
  ///
  ///Otherwise, the function returns a [GridView] using the [count] method.
  ///It contains the [crossAxisCount] attribute representing the set number of columns in the grid
  ///and the [returnImagePlacesList] helper function call for generating the gride items.
  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'No places added yet',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }
    return GridView.count(
      crossAxisCount: 3,
      children: returnImagePlacesList(
          places),
    );
  }

  ///Generates a list of [ImageBox] widgets from the list of [Place] objects.
  ///
  ///Takes one parameter - a [List<Place>] list [places].
  ///The function initializes [images] - an empty list of [ImageBox] widgets.
  ///The [places] list is iterated and each [Place] object from the list is used for creating an [ImageBox] object.
  ///Each of these objects is then added to the [images] list.
  ///The [images] list is returned.
  List<ImageBox> returnImagePlacesList(List<Place> places) {
    List<ImageBox> images = [];
    for (var i = 0; i < places.length; i++) {
      images.add(ImageBox(
          place: places[
              i]));
    }
    return images;
  }
}
