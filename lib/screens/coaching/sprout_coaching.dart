import 'dart:async';

import 'package:animated_flip_widget/animated_flip_widget/flip_controler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sprout/constants/colors.dart';
import 'package:sprout/constants/list.dart';
import 'package:sprout/constants/strings.dart';
import 'package:sprout/global/decortions.dart';
import 'package:sprout/global/extensions.dart';
import 'package:sprout/widgets/custom_images.dart';
import 'package:sprout/widgets/custom_widgets.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

import '../../constants/icons.dart';

class SproutCoaching extends StatefulWidget {
  const SproutCoaching({super.key});

  @override
  State<SproutCoaching> createState() => _SproutCoachingState();
}

class _SproutCoachingState extends State<SproutCoaching> {
  bool choose = false;
  int seconds = 0, current = 0, total = 0;
  Timer? timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    debugPrint('down');
    timer = Timer.periodic(oneSec, (timer) => handleClicks());
    setState(() {});
  }

  handleClicks() {
    setState(() {
      if (seconds == 0) {
        timer!.cancel();
      } else {
        seconds = seconds - 1;
        current = current + 1;
        debugPrint('current: $current');
      }
    });
  }

  @override
  void dispose() {
    if (timer != null && timer!.isActive) timer!.cancel();
    super.dispose();
  }

  final controller = FlipController();
  FlipDirection direction = FlipDirection.vertical;
  @override
  Widget build(BuildContext context) {
    double percent = total == 0 ? 0 : (current / total);
    return Scaffold(
      appBar: const CustomAppbar(title: '${AppStrings.appname} Coaching'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: context.width,
              //color: const Color(0xffDFFFC2),
              padding: pageMargin,
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // FlutterSwitch(
                  //   value: choose,
                  //   onToggle: (value) {
                  //     setState(() {
                  //       choose = value;
                  //     });
                  //   },
                  //   showOnOff: true,
                  //   width: 110,
                  //   height: 40,
                  //   activeColor: Colors.white,
                  //   inactiveColor: Colors.white,
                  //   toggleColor: Colors.black,
                  //   switchBorder: Border.all(color: Colors.black, width: 4),
                  //   toggleBorder: Border.all(color: Colors.black, width: 4),
                  //   activeText: 'Choose',
                  //   inactiveText: 'Random',
                  //   activeTextColor: Colors.black,
                  //   inactiveTextColor: Colors.black,
                  // ),

                  InkWell(
                    onTap: () {
                      debugPrint('tap');
                      if (seconds == 0 && current == 0) {
                        Picker(
                          adapter: NumberPickerAdapter(
                            data: <NumberPickerColumn>[
                              const NumberPickerColumn(
                                begin: 5,
                                end: 45,
                                suffix: Text(' minutes'),
                                jump: 5,
                              ),
                            ],
                          ),
                          hideHeader: true,
                          confirmText: 'OK',
                          confirmTextStyle: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(color: AppColors.primary),
                          cancelTextStyle: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(),
                          title: const Headline('Select duration'),
                          selectedTextStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppColors.primary),
                          onConfirm: (Picker picker, List<int> value) {
                            Duration duration = Duration(
                              minutes: picker.getSelectedValues()[0],
                            );
                            seconds = duration.inSeconds;
                            total = seconds;
                            setState(() {});
                          },
                        ).showDialog(context);
                      } else if (seconds != 0 && current == 0) {
                        setState(() {
                          startTimer();
                        });
                      }
                    },
                    child: CircularPercentIndicator(
                      radius: 30.0,
                      lineWidth: 4.0,
                      percent: percent,
                      center: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Headline(
                          "${(percent * 100).toStringAsFixed(0)}%",
                          fontsize: 17,
                          align: TextAlign.center,
                        ),
                      ),
                      progressColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: List.generate(
                12,
                (index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      clickImage(
                        AppIcons.plant2,
                        ontap: () => onImageTap(index, AppIcons.plant2, plant),
                      ),
                      clickImage(
                        AppIcons.water2,
                        ontap: () => onImageTap(index, AppIcons.water2, water),
                      ),
                      clickImage(
                        AppIcons.prune2,
                        ontap: () => onImageTap(index, AppIcons.prune2, prune),
                      ),
                      clickImage(
                        AppIcons.harvest2,
                        ontap: () =>
                            onImageTap(index, AppIcons.harvest2, harvest),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  onImageTap(int index, String icon, List<String> list) {
    if (choose) {
      allTiles(context, list);
    } else {
      singleTileDialog(context, list[index], icon);
    }
  }

  Widget clickImage(String image, {VoidCallback? ontap}) {
    return InkWell(
      onTap: ontap,
      child: CustomImageWidget(
        image: image,
      ),
    );
  }
}

allTiles(BuildContext context, List<String> list) {
  SwipeableCardSectionController cardController =
      SwipeableCardSectionController();
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: pageMargin,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwipeableCardsSection(
                    cardHeightTopMul: 0.75,
                    cardHeightMiddleMul: 0.76,
                    cardHeightBottomMul: 0.735,
                    cardController: cardController,
                    context: context,
                    items: List.generate(
                      list.length,
                      (index) => CardWidget(text: list[index]),
                    ),
                    onCardSwiped: (dir, index, widget) {
                      if (index == list.length - 1) {
                        Navigator.of(context).pop();
                      } else {
                        cardController.addItem(CardWidget(text: list[index]));
                      }
                    },
                    enableSwipeUp: true,
                    enableSwipeDown: false,
                  ),
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.2,
      width: context.width,
      alignment: Alignment.center,
      padding: pageMargin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppDecorations.appShadow(),
      ),
      child: BodyText(
        text,
        fontsize: 20,
        font: GoogleFonts.fredoka().fontFamily,
        align: TextAlign.center,
      ),
    );
  }
}

singleTileDialog(BuildContext context, String text, String icon) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          10.vertical,
          assetImage(icon),
          20.vertical,
          BodyText(
            text,
            fontsize: 20,
            font: GoogleFonts.fredoka().fontFamily,
            align: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
