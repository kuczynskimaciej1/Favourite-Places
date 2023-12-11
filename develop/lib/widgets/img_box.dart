import 'package:develop/providers/user_places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:develop/models/place.dart';
import 'package:develop/screens/place_detail.dart';
import 'dart:io' show File;

///A [ConsumerWidget] (part of [Riverpod] for reactive state management).
class ImageBox extends ConsumerWidget {
  ///Constructor requiring a [Place] object and an optional key.
  const ImageBox(
      {required this.place,
      super.key});

  ///Immutable variable [place] of type [Place].
  final Place place;

  ///Takes context and [WidgedRef] from state management.
  ///
  ///Returns an [InkWell] widget for tap detection containing:
  ///
  ///* An [onTap] callback function
  ///redirectiong to the [Navigator.of(context).push] function which navigates to a new screen on tap
  ///using the [MaterialPageRoute], finally reaching the [PlaceDetailScreen] with the current [place].
  ///* a [child] attribute of type [Container] which serves as a containter for the image.
  ///The container is decorated with [DecorationImage] and displayed with [FileImage].
  ///The child widget is stacked using a [Stack] child for layering widgets.
  ///The [Stack] object contains its [IconButton] delete button arranged using a [Position] class.
  ///Deleting the place uses [Riverpod] state management.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => PlaceDetailScreen(place: place),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(
                place.image),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 80,
              top: -5,
              child: IconButton(
                icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.primaryContainer),
                onPressed: () async {
                  await ref.read(userPlacesProvider.notifier).deletePlace(place.id);
                  ref.read(userPlacesProvider).remove(place);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///Returns an [Image] widget based on input parameters.
///
///Strings for asset and URL, and a [File] object, are checked whether they are not null.
///* If the [i] asset string is not null, an [Image] object is returned from assets.
///* Else if the [iU] URL string is not null, an [Image] object is returned from a network URL.
///* Else if the [iF] [File] is not null, an [Image] object is returned from a file.
///* Otherwise, an empty [Image] asset is returned.
Image returnImg(String? i, String? iU, File? iF) {
  if (i != null) {
    return Image.asset(
      i,
      width: 125,
      height: 125,
    );
  } else if (iU != null) {
    return Image.network(
      iU,
      width: 125,
      height: 125,
    );
  } else if (iF != null) {
    return Image.file(
      iF,
      width: 125,
      height: 125,
    );
  } else {
    return Image.asset(
      '',
      width: 125,
      height: 125,
    );
  }
}
