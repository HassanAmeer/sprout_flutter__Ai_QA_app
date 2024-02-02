import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sprout/constants/colors.dart';
import 'package:sprout/constants/strings.dart';
import 'package:sprout/global/extensions.dart';
import 'package:sprout/screens/auth/signup.dart';
import 'package:sprout/screens/home.dart';
import 'package:sprout/themes/input_decoration.dart';
import 'package:sprout/widgets/custom_buttons.dart';
import 'package:sprout/widgets/custom_images.dart';
import 'package:sprout/widgets/custom_widgets.dart';

import '../../constants/icons.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController(),
      password = TextEditingController();

  userLogin(BuildContext context) async {
    log("${email.text}  ${password.text}");
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text);
      log("${user.user!.email}");
      for (var x in user.user!.providerData) {
        log("user: ${x.providerId}");
      }
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      log("${e.code} ${e.message}");
      String value = "";
      if (e.code == "invalid-email" || e.code == "wrong-password") {
        value = "You Have Entered Wrong Credentials";
      } else if (e.code == "user-disabled") {
        value = "Your Account is Disabled.";
      } else if (e.code == "user-not-found") {
        value = "Your Account is not Created";
      }
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              value,
              style: const TextStyle(color: Colors.black),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Ok"),
              ),
            ],
          );
        },
      );
    }
    log("after");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Container(
          //   width: context.width,
          //   height: context.height,
          //   alignment: Alignment.bottomLeft,
          //   child: SvgPicture.asset(AppIcons.background, width: context.width),
          // ),
          Form(
            key: form,
            child: Padding(
              padding: pageMargin,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  50.vertical,
                  assetImage(AppIcons.logoPNG, height: 66),
                  Headline(
                    'Welcome Back!',
                    color: AppColors.primary,
                    fontsize: 24,
                    font: AppStrings.font,
                  ),
                  5.vertical,
                  const BodyText(
                    'Enter Your Username & Password',
                    fontsize: 13,
                    color: AppColors.primary,
                  ),
                  const Spacer(),
                  TextFormField(
                    controller: email,
                    textInputAction: TextInputAction.next,
                    decoration: inputDecoration(hint: 'Username'),
                    validator: (val) {
                      if (val!.isEmpty) return '*Required';
                      return null;
                    },
                  ),
                  30.vertical,
                  TextFormField(
                    obscureText: true,
                    controller: password,
                    textInputAction: TextInputAction.done,
                    decoration: inputDecoration(hint: 'Password'),
                    validator: (val) {
                      if (val!.isEmpty) return '*Required';
                      return null;
                    },
                  ),
                  100.vertical,
                  Center(
                    child: Column(
                      children: [
                        CustomElevatedButton(
                          text: 'Login'.toUpperCase(),
                          btnWidth: context.width * 0.5,
                          font: GoogleFonts.inder().fontFamily,
                          radius: 20,
                          fontsize: 20,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            form.currentState!.save();
                            if (form.currentState!.validate()) {
                              showLoader(context);
                              userLogin(context);
                              // Navigator.of(context).pushAndRemoveUntil(
                              //   MaterialPageRoute(
                              //       builder: (context) => const HomePage()),
                              //   (route) => false,
                              // );
                            }
                          },
                        ),
                        20.vertical,
                        const CustomTextButton(
                          title: 'Forgot Password?',
                          color: AppColors.textSecondary,
                          fontsize: 14,
                        ),
                        CustomTextButton(
                          fontsize: 14,
                          title: 'Or Create a New Account',
                          color: AppColors.textSecondary,
                          onpressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showLoader(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        });
  }
}
