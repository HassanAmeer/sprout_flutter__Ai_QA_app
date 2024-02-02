import 'package:flutter/material.dart';

import '../constants/colors.dart';

outlineButton({
  Color? primary = AppColors.primary,
  Color? surface = AppColors.primary,
  Color? borderColor = AppColors.primary,
  double? radius = 10.0,
  double? elevation,
  double width = 1.0,
}) {
  return OutlinedButton.styleFrom(
    foregroundColor: primary ?? AppColors.primary,
    elevation: elevation,
    disabledForegroundColor: surface!.withOpacity(0.38),
    shadowColor: Colors.transparent,
    side: BorderSide(color: borderColor!, width: width),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
  );
}

elevatedButton({
  required Color primary,
  Color? surface = Colors.white,
  required Color? borderColor,
  Color onPrimary = Colors.white,
  double? radius = 10.0,
  Color? shadowColor,
  double? elevation,
}) {
  return ElevatedButton.styleFrom(
    foregroundColor: onPrimary,
    backgroundColor: primary,
    disabledForegroundColor: surface!.withOpacity(0.38),
    disabledBackgroundColor: surface.withOpacity(0.12),
    elevation: elevation,
    shadowColor: shadowColor,
    side: BorderSide(color: borderColor!),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
  );
}
