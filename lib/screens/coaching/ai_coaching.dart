import 'package:flutter/material.dart';
import 'package:sprout/widgets/custom_widgets.dart';

class AiCoaching extends StatefulWidget {
  const AiCoaching({super.key});

  @override
  State<AiCoaching> createState() => _AiCoachingState();
}

class _AiCoachingState extends State<AiCoaching> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppbar(title: 'Ai Coaching'),
     
    );
  }
}
