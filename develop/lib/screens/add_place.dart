import 'dart:io';
import 'package:develop/models/place.dart';
import 'package:develop/widgets/location_input.dart';
import 'package:develop/background.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:develop/widgets/image_input.dart';
import 'package:develop/providers/user_places.dart';

///A [StatefulWidget] that uses [Riverpod] for state management.
class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

///Creates a state for this widget.
  @override
  ConsumerState<AddPlaceScreen> createState() =>
      _AddPlaceScreenState();
}

///A [ConsumerState<AddPlaceScreen>] class.
class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  ///The defined state for AddPlaceScreen widget. [TextEditingController] is a controller for text input for the title.
  final _titleController =
      TextEditingController();
  ///Tthe selected image file.
  File? _selectedImage;
  ///The selected location.
  PlaceLocation?
      _selectedLocation;

  ///Creates a [Scaffold] for a saved place.
  ///
  ///A [SnackBar] is shown if:
  ///* title is empty,
  ///* image was not picked,
  ///* localization is empty,
  ///The [Riverpod] provider to add a new place with the given title, image, and location.
  ///The [Navigator.of(context).pop] function pops the current screen off the navigation stack after saving.
  void _savePlace() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a title'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select an image'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    if (_selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a location'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredTitle, _selectedImage!, _selectedLocation!);

    Navigator.of(context).pop();
  }

  ///Cleans up the controller when the widget is removed from the tree.
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  ///Renders the UI of this widget.
  ///
  ///Uses [Scaffold] to provide a layout structure like app bars, body, etc.
  ///The [appBar] attribute provides a [Text] object for the AppBar title.
  ///The [childBody] attribute of type [Center] allows for centering the content.
  ///Its parameter [child] of type [SingleChildScrollView] allows for scrolling the screen if necessary.
  ///[SizedBox] objects maintain spacing between widgets.
  ///An [ImageInput] widget allows for a custom widget for image input.
  ///When an image is picked, a callback is raised and the selected image is stored inside the [_selectedImage] variable.
  ///A [LocationInput] widget allows for a custom widget for location input.
  ///When location is picked, a callback is raised and the selected location is stored inside the [_selectedLocation] variable.
  ///
  ///An [ElevatedButton] object serves as a "save" action trigger.
  ///When pressed, the [_savePlace] method is called.
  ///[icon] and [label] variables store the [Icon] and [Label] features of the button.
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    var scaledPadding = screenWidth * 0.03;
    var scaledSpacing = screenHeight * 0.01;
    var scaledFontSize = screenHeight * 0.02;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add new Place',
        ),
      ),
      body: CustomScaffold(
        childBody: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(scaledPadding),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                      hintStyle: TextStyle(
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                      helperStyle: TextStyle(
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              width: 1.7))),
                  controller: _titleController,
                  style: TextStyle(
                    fontSize: scaledFontSize,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  cursorColor: Theme.of(context).colorScheme.primaryContainer,
                ),
                SizedBox(height: scaledSpacing),
                ImageInput(
                  onPickImage: (image) {
                    _selectedImage = image;
                  },
                ),
                const SizedBox(height: 10),
                LocationInput(
                  onSelectLocation: (location) {
                    _selectedLocation =
                        location;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _savePlace,
                  icon: const Icon(Icons.add),
                  label: const Text('Save Place'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
