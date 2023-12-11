import 'package:develop/background.dart';
import 'package:flutter/material.dart';

///A [StatelessWidget] class.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  ///Creates a splash screen during the loading screen from login to photos screen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScaffold(
        childBody: Center(
          child: Text(
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
              'Loading...'),
        ),
      ),
    );
  }
}
