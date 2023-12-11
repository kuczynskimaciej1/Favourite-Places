import 'package:develop/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:develop/widgets/places_list.dart';
import 'package:develop/screens/add_place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:develop/providers/user_places.dart';

///A [ConsumerStatefulWidget] class.
class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  ///Creates a state for photos placing.
  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlacesScreenState();
  }
}

///A [ConsumerState<PlacesScreen>] class.
class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  ///A [Future<void>] variable for future places storage.
  late Future<void> _placesFuture;

  ///Initializes state for [_placesFuture].
  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  ///Builds a widget.
  ///
  ///A [userPlaces] variable retrieves data from the [userPlacesProvider].
  ///A [Scaffold] object is returned for background settings.
  ///A [FutureBuilder] widget is used to build UI based on the latest snapshot of interaction with a future.
  ///Its [builder] function that defines the UI based on the state of the future.
  ///Inside this funtion, if the [ConnectionState] is waiting display a [CircularProgressIndicator] widget in the center.
  ///If the future is completed, the [PlacesList] widget is displayed with the [userPlaces] data.
  @override
  Widget build(BuildContext context) {
    final userPlaces = ref
        .watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0.0,
        title: const Text('Favourite Places'),
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const AddPlaceScreen(),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: CustomScaffold(
          childBody: FutureBuilder(
            future:
                _placesFuture,
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : PlacesList(
                        places: userPlaces,
                      ),
          ),
        ),
      ),
    );
  }
}
