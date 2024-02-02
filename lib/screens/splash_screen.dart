import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sprout/global/extensions.dart';
import 'package:sprout/screens/auth/login.dart';
import 'package:sprout/screens/home.dart';
import 'package:sprout/widgets/custom_images.dart';

import '../constants/colors.dart';
import '../constants/icons.dart';
import '../widgets/custom_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => FirebaseAuth.instance.currentUser == null
                  ? LoginScreen()
                  : const HomePage()),
          (route) => false,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const Spacer(),
          150.vertical,
          assetImage(AppIcons.logoPNG),
          const Spacer(),
          SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? AppColors.primary : null,
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
          10.vertical,
          const BodyText(
            'Loading...',
            color: AppColors.primary,
            align: TextAlign.center,
          ),
          30.vertical,
        ],
      ),
    );
  }
}
