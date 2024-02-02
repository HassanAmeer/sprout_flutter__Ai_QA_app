import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sprout/constants/strings.dart';
import 'package:sprout/firebase_options.dart';
import 'package:sprout/screens/splash_screen.dart';
import 'package:sprout/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appname,
      theme: apptheme(),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
