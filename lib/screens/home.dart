import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sprout/constants/strings.dart';
import 'package:sprout/global/decortions.dart';
import 'package:sprout/global/extensions.dart';
import 'package:sprout/screens/chats/ask_ai.dart';
import 'package:sprout/screens/coaching/sprout_coaching.dart';
import 'package:sprout/screens/instructions.dart';
import 'package:sprout/widgets/custom_images.dart';
import 'package:sprout/widgets/custom_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Headline(
          AppStrings.appname,
          color: Colors.white,
          fontsize: 26,
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: assetImage(AppIcons.settings),
        //   ),
        // ],
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: SizedBox(
            width: context.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: context.width,
                      height: context.height * 0.28,
                    ),
                    Container(
                      width: context.width,
                      height: context.height * 0.23,
                      color: const Color(0xffC1E0A5),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: AppDecorations.ImageShadow(),
                              ),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    providerImage("assets/logo.png"),
                              ),
                            ),
                            Headline(FirebaseAuth.instance.currentUser!.email!,
                                color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                20.vertical,
                DrawerTile(
                  AppIcons.home,
                  'Home',
                  ontap: () => Navigator.of(context).pop(),
                ),
                // DrawerTile(
                //   AppIcons.profile,
                //   'Profile',
                //   ontap: () {
                //     Navigator.of(context)
                //       ..pop()
                //       ..push(
                //         MaterialPageRoute(
                //           builder: (context) => const SproutCoaching(),
                //         ),
                //       );
                //   },
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Instructions(
                          index: 0,
                          name: '1:1 Coaching',
                        ),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        "1:1 Coaching",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Instructions(
                          index: 1,
                          name: 'Pod Coaching',
                        ),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        "Pod Coaching",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Instructions(
                          index: 2,
                          name: 'Reciprocal Coaching',
                        ),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        "Reciprocal Coaching",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                // DrawerTile(
                //   AppIcons.about,
                //   'About',
                //   ontap: () {
                //     Navigator.of(context)
                //       ..pop()
                //       ..push(
                //         MaterialPageRoute(
                //           builder: (context) => const AiCoaching(),
                //         ),
                //       );
                //   },
                // ),
                DrawerTile(
                  AppIcons.contact,
                  'Contact',
                  ontap: () async {
                    launchUrl(
                      Uri.parse("mailto:sproutcoachingapp@gmail.com"),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                ),
                //const DrawerTile(AppIcons.website, 'Website'),
                DrawerTile(
                  AppIcons.feedback,
                  'Feedback',
                  ontap: () async {
                    launchUrl(
                      Uri.parse("mailto:sproutcoachingapp@gmail.com"),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                ),
                // 10.vertical,
                // drawerSeparator('Socials'),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       7.vertical,
                //       const BodyText('Linked In'),
                //       5.vertical,
                //       const BodyText('Twitter'),
                //       5.vertical,
                //       const BodyText('Instagram'),
                //       5.vertical,
                //       const BodyText('Facebook'),
                //       5.vertical,
                //       const BodyText('E-mail'),
                //       7.vertical,
                //     ],
                //   ),
                // ),
                // drawerSeparator('More'),
                // const DrawerTile(AppIcons.settings1, 'Settings'),
                // const DrawerTile(AppIcons.privacy, 'Privacy'),
                // 50.vertical,
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       const BodyText('App Version - V2.00', fontsize: 12),
                //       CustomTextButton(
                //         title: 'Logout',
                //         color: Colors.black,
                //         fontsize: 12,
                //         onpressed: () {
                //           Navigator.of(context).pushAndRemoveUntil(
                //             MaterialPageRoute(
                //                 builder: (context) => LoginScreen()),
                //             (route) => false,
                //           );
                //         },
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            buttonBox(
              size,
              "assets/icons/3.png",
              "Practice Coaching\nUsing Sprout",
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const SproutCoaching()),
                );
              },
            ),
            buttonBox(
              size,
              "assets/icons/2.png",
              "Practice Coaching\nUsing Sprout & AI",
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AskAiScreen()),
                );
              },
            ),
            // buttonBox(
            //   size,
            //   "",
            //   "1:1 Coaching",
            //   () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (_) => Instructions(
            //           index: 0,
            //           name: '1:1 Coaching',
            //         ),
            //       ),
            //     );
            //   },
            // ),
            // buttonBox(
            //   size,
            //   "",
            //   "Pod Coaching",
            //   () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (_) => Instructions(
            //           index: 1,
            //           name: '"Pod Coaching',
            //         ),
            //       ),
            //     );
            //   },
            // ),
            // buttonBox(
            //   size,
            //   "",
            //   "Reciprocal Coaching",
            //   () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (_) => Instructions(
            //           index: 2,
            //           name: 'Reciprocal Coaching',
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget buttonBox(Size size, String image, String text, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Container(
            //   color: Colors.white,
            //   child: Image.asset(
            //     image,
            //     height: 50,
            //     width: 50,
            //   ),
            // ),
            // const SizedBox(
            //   width: 10,
            // ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                //color: AppColors.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerSeparator(String title) {
    return Row(
      children: [
        const SizedBox(width: 50, child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: BodyText(title, weight: FontWeight.bold),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile(this.icon, this.title, {super.key, this.ontap});
  final String icon, title;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 5,
      leading:
          icon.contains('.svg') ? SvgPicture.asset(icon) : assetImage(icon),
      title: BodyText(title, color: const Color(0xff222222), fontsize: 15),
      onTap: ontap,
      visualDensity: VisualDensity.compact,
      minVerticalPadding: 0,
    );
  }
}
