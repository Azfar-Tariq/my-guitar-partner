import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: Center(
                child: Image.asset(
                  'assets/images/Instagram_Profile_Image.png',
                  height: 250,
                  width: 250,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SpinKitWave(
              color: Colors.lightBlue,
              size: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}
