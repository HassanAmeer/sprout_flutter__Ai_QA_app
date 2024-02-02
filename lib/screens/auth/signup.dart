import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sprout/global/extensions.dart';
import 'package:sprout/widgets/custom_buttons.dart';

import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../../constants/strings.dart';
import '../../themes/input_decoration.dart';
import '../../widgets/custom_images.dart';
import '../../widgets/custom_widgets.dart';
import '../home.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController(),
      password = TextEditingController(),
      username = TextEditingController();

  Future<bool> registerUser(BuildContext context) async {
    log("${email.text}  ${password.text}");
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);
      log("${user.user!.email}");
      return true;
    } on FirebaseAuthException catch (e) {
      log("${e.code} ${e.message}");

      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(e.message!),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            child: SingleChildScrollView(
              padding: pageMargin,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  50.vertical,
                  assetImage(AppIcons.logoPNG, height: 66),
                  Headline(
                    'Create Account :)',
                    color: AppColors.primary,
                    fontsize: 24,
                    font: AppStrings.font,
                  ),
                  (context.height * 0.2).toInt().vertical,
                  const BodyText(
                    'Enter Email Id',
                    fontsize: 17,
                    color: AppColors.textSecondary,
                  ),
                  5.vertical,
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: inputDecoration(),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return '*Required';
                      } else if (!val.isValidEmail) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  20.vertical,
                  const BodyText(
                    'Create Username',
                    fontsize: 17,
                    color: AppColors.textSecondary,
                  ),
                  5.vertical,
                  TextFormField(
                    controller: username,
                    textInputAction: TextInputAction.next,
                    decoration: inputDecoration(),
                    validator: (val) {
                      if (val!.isEmpty) return '*Required';
                      return null;
                    },
                  ),
                  20.vertical,
                  const BodyText(
                    'Create Password',
                    fontsize: 17,
                    color: AppColors.textSecondary,
                  ),
                  5.vertical,
                  TextFormField(
                    obscureText: true,
                    controller: password,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: inputDecoration(),
                    validator: (val) {
                      if (val!.isEmpty) return '*Required';
                      return null;
                    },
                  ),
                  20.vertical,
                  Center(
                    child: CustomElevatedButton(
                      text: 'Signup'.toUpperCase(),
                      btnWidth: context.width * 0.5,
                      fontsize: 20,
                      radius: 20,
                      font: GoogleFonts.inder().fontFamily,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        form.currentState!.save();
                        if (form.currentState!.validate()) {
                          showLoader(context);
                          registerUser(context).then(
                            (value) {
                              if (value) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                    (route) => false);
                              }
                            },
                            onError: (e) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Registration Failed... Try Again Later"),
                                ),
                              );
                            },
                          );
                          // Navigator.of(context).pushAndRemoveUntil(
                          //   MaterialPageRoute(
                          //     builder: (context) => const HomePage(),
                          //   ),
                          //   (route) => false,
                          // );
                        }
                      },
                    ),
                  ),
                  (context.height * 0.1).toInt().vertical,
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
