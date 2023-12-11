import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

///A [StatefulWidget] class.
class ImageInput extends StatefulWidget {
  ///Constructor with a required callback function.
  const ImageInput(
      {super.key,
      required this.onPickImage});

  ///Callback function to be called when an image is picked.
  final void Function(File image)
      onPickImage;

  ///Create state for [ImageInput].
  @override
  State<ImageInput> createState() =>
      _ImageInputState();
}

///A state class for [ImageInput] widget.
class _ImageInputState extends State<ImageInput> {
  ///The selected image file.
  File? _selectedImage;

  ///Captures an image using the camera.
  ///
  ///An [imagePicker] variable stores the [ImagePicker] instance.
  ///A [pickedImage] variable stores the information about image source (from the camera) and the maximum width for the image.
  ///If no image is picked, the function returns null.
  ///Otherwise, the state is updated with the picked image file using the [setState] function
  ///and the [widged.onPickImage] callback function is called.
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(
          pickedImage.path);
    });

    widget.onPickImage(
        _selectedImage!);
  }

  ///Builds the UI for the widget.
  ///
  ///Its default [content] is a button to take a picture.
  ///When the button is pressed, the [_takePicture] function is called.
  ///
  ///If the selected image is not null, update the content to show it with the [GestureDetector] class.
  ///On tap, the picture is retaken.
  ///The attributes: [fit] of type [BoxFit.cover], [width] of type [double.infinity] and [height] of type [double.infinity]
  ///help to keep the entire space of the container covered.
  ///
  ///A main container widget for the [ImageInput] is returned.
  ///The [height], [width] and [alignment] attribute represent its location, while [child] makes it displayed.
  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: Icon(Icons.camera, color: Theme.of(context).colorScheme.primaryContainer),
      label: Text(
        'Take Picture',
        style: Theme.of(context).textTheme.titleLarge!.copyWith( color: Theme.of(context).colorScheme.primaryContainer ),
      ),
      onPressed:
          _takePicture,
    );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      height: 250,
      width: double.infinity,
      alignment:
          Alignment.center,
      child: content,
    );
  }
}
