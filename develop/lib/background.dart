import 'package:flutter/material.dart';

/// A custom scaffold widget that provides a background gradient based on the
/// system's brightness mode (light or dark). This widget is designed to be
/// used as a container for the main body of an application screen.
///
/// The background gradient adapts to the system's brightness mode, with
/// customizable color options for both light and dark modes.
class CustomScaffold extends StatelessWidget {
  /// The main body of the scaffold.
  final Widget childBody;

  /// Creates a [CustomScaffold] with the specified [childBody].
  ///
  /// The [childBody] parameter must not be null.
  const CustomScaffold({super.key, required this.childBody});

  ///Returns a color widget describing the color mode.
  @override
  Widget build(BuildContext context) {
    ///Whether dark mode is on.
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    ///Defines the proper color gradient for the dark mode and bright mode,
    ///basing on the condition whether [isDarkMode] is true or false.
    ///The color gradient is defined using the [Color] class and [fromARGB] funtions.
    ///The number of colors is unlimited.
    final List<Color> gradientColors = isDarkMode
        ? [
            const Color.fromARGB(255, 54, 42, 33),
            const Color.fromARGB(255, 73, 53, 40),
            const Color.fromARGB(255, 82, 58, 48),
            const Color.fromARGB(255, 110, 83, 62),
          ]
        : [
            const Color(0xFF49362a),
            const Color(0xFF4c382b),
            const Color(0xFF533c2e),
            const Color(0xFF5d4333),
            const Color(0xFF6b4c38),
            const Color(0xFF7a563f),
            const Color(0xFF8b6046),
            const Color(0xFF9b6b4c),
            const Color(0xFFaa7452),
            const Color(0xFFb67c57),
            const Color(0xFFbe815b),
            const Color(0xFFc1835c)
          ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: childBody,
    );
  }
}
