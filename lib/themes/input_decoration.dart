import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/strings.dart';

InputDecoration inputDecoration({
  Widget? icon,
  String? helper,
  String? hint,
  String? error,
  String? label,
  Widget? suffix,
  Widget? prefix,
  Color? filledColor,
  InputBorder? border,
  InputBorder? errorBorder,
  InputBorder? focusBorder,
  bool? filled = false,
  double radius = 4,
  bool? dense = true,
  double hintSize = 16,
  String? fontFamily,
  Color? errorColor = AppColors.error,
  Color? hintColor = AppColors.textSecondary,
  Color? focusColor = AppColors.accent,
  Color? labelColor = AppColors.accent,
  Color? helperColor = AppColors.accent,
  Color? borderColor = AppColors.accent,
  double labelsize = 14,
  FontWeight labelWeight = FontWeight.normal,
  FontWeight hintWeight = FontWeight.normal,
  EdgeInsetsGeometry? padding,
}) {
  return InputDecoration(
    icon: icon,
    hintText: hint,
    isDense: dense,
    filled: filled,
    errorText: error,
    labelText: label,
    helperText: helper,
    suffixIcon: suffix,
    prefixIcon: prefix,
    fillColor: filledColor,
    focusColor: AppColors.accent,
    contentPadding: padding ?? const EdgeInsets.all(15),
    helperStyle: TextStyle(
      color: helperColor,
      fontFamily: fontFamily ?? AppStrings.font,
      fontSize: hintSize,
      fontWeight: FontWeight.normal,
    ),
    errorStyle: TextStyle(
      color: errorColor,
      fontFamily: fontFamily ?? AppStrings.font,
      fontSize: hintSize,
      fontWeight: FontWeight.normal,
    ),
    labelStyle: TextStyle(
      color: labelColor,
      fontFamily: fontFamily ?? AppStrings.font,
      fontSize: labelsize,
      fontWeight: labelWeight,
    ),
    hintStyle: TextStyle(
      color: hintColor,
      fontFamily: fontFamily ?? AppStrings.font,
      fontSize: hintSize,
      fontWeight: hintWeight,
    ),
    border: border ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor!),
          borderRadius: BorderRadius.circular(radius),
        ),
    enabledBorder: border ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor!),
          borderRadius: BorderRadius.circular(radius),
        ),
    focusedBorder: focusBorder ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: focusColor!),
          borderRadius: BorderRadius.circular(radius),
        ),
    errorBorder: errorBorder ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: errorColor!),
          borderRadius: BorderRadius.circular(radius),
        ),
    focusedErrorBorder: errorBorder ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: errorColor!),
          borderRadius: BorderRadius.circular(radius),
        ),
    disabledBorder: border ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor!),
          borderRadius: BorderRadius.circular(radius),
        ),
  );
}

decoration({
  String? hint,
  String? label,
  Widget? suffix,
  Widget? prefix,
  double? radius,
  Color? color,
  double? width,
  bool? fill,
  Color? fillColor,
  EdgeInsetsGeometry? padding,
  String? fontFamily,
  Color? hintcolor,
}) {
  return inputDecoration(
    hint: hint,
    label: label,
    suffix: suffix,
    prefix: prefix,
    filled: fill ?? false,
    hintColor: hintcolor,
    fontFamily: fontFamily ?? AppStrings.font,
    filledColor: fillColor ?? Colors.grey,
    padding: padding ,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 4.0),
      borderSide: BorderSide(
        color: color ?? AppColors.accent,
        width: width ?? 1,
      ),
    ),
    focusBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 4.0),
      borderSide: BorderSide(
        color: color ?? AppColors.accent,
        width: width ?? 1,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 4.0),
      borderSide: BorderSide(
        color: color ?? AppColors.accent,
        width: width ?? 1,
      ),
    ),
  );
}
