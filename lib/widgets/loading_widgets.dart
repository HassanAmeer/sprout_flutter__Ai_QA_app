// ignore_for_file: unused_local_variable, use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/strings.dart';

Center progressIndicator() {
  return Center(
    child: CircularProgressIndicator(
      color: Colors.white,
      backgroundColor: Colors.black,
    ),
  );
}

class CircularLoadingWidget extends StatefulWidget {
  final double height;
  final ValueChanged<void>? onComplete;
  final String onCompleteText;
  final int duration, forward;

  const CircularLoadingWidget({
    Key? key,
    required this.height,
    this.onComplete,
    required this.onCompleteText,
    this.duration = 300,
    this.forward = 10,
  }) : super(key: key);

  @override
  _CircularLoadingWidgetState createState() => _CircularLoadingWidgetState();
}

class _CircularLoadingWidgetState extends State<CircularLoadingWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: widget.duration), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation = Tween<double>(begin: widget.height, end: 0).animate(curve)
      ..addListener(() {
        if (mounted) setState(() {});
      });
    Timer(Duration(seconds: widget.forward), () {
      if (mounted) animationController.forward();
      widget.onComplete;
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return animationController.isCompleted
        ? Container(
            width: width,
            height: widget.height,
            color: Colors.transparent,
            child: Center(
              child: Text(
                widget.onCompleteText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.merge(
                      TextStyle(fontSize: 14, fontFamily: AppStrings.font),
                    ),
              ),
            ),
          )
        : Opacity(
            opacity: animation.value / 100 > 1.0 ? 1.0 : animation.value / 100,
            child: SizedBox(
              height: animation.value,
              child: Center(child: progressIndicator()),
            ),
          );
  }
}
