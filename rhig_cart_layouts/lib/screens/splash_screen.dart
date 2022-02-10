import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColour,
      padding: const EdgeInsets.all(50.0),
      child: GestureDetector(
        //TODO: Remove temp GestureDetector from splash screen, it is only in place for testing
        onTap: () {
          Navigator.pushNamed(
            context,
            '/login',
          );
        },
        child: Image.asset(
          'assets/images/logo.png',
        ),
      ),
    );
  }
}
