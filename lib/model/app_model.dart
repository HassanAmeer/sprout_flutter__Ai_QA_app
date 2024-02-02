import 'package:flutter/material.dart';

class AppModel {
  String title;
  int value;
  String? image, about;
  IconData? icon;
  Color? color;
  int? type;

  AppModel(
    this.title,
    this.value, {
    this.image,
    this.type,
    this.about,
    this.icon,
    this.color,
  });
}
