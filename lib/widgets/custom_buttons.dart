import 'package:flutter/material.dart';
import 'package:sprout/constants/strings.dart';

import '../constants/colors.dart';
import '../themes/button_theme.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.btnWidth,
    this.btnHeight,
    this.weight,
    this.borderColor,
    this.textColor,
    this.radius,
    this.fontsize,
    this.icon,
    this.decoration,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final double? btnWidth, btnHeight, radius, fontsize;
  final FontWeight? weight;
  final Color? textColor, borderColor;
  final Widget? icon;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: btnWidth ?? width,
      height: btnHeight ?? 45,
      child: OutlinedButton(
        onPressed: onPressed ?? () {},
        style: outlineButton(
          primary: borderColor ?? AppColors.primary,
          borderColor: borderColor ?? AppColors.primary,
          radius: radius ?? 30,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? Container(),
            Padding(
              padding: EdgeInsets.only(left: icon == null ? 0 : 10),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: weight ?? FontWeight.normal,
                      color: textColor ?? AppColors.primary,
                      fontSize: fontsize ?? 17,
                      decoration: decoration ?? TextDecoration.underline,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.btnWidth,
    this.btnHeight,
    this.weight,
    this.radius,
    this.textColor,
    this.primary,
    this.elevation,
    this.icon,
    this.fontsize,
    this.child,
    this.decoration,
    this.suffix,
    this.font,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final double? btnWidth, btnHeight, radius, elevation, fontsize;
  final FontWeight? weight;
  final Color? textColor, primary;
  final Widget? icon, child, suffix;
  final TextDecoration? decoration;
  final String? font;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: btnWidth ?? width,
      height: btnHeight ?? 40,
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
        style: elevatedButton(
          radius: radius ?? 10,
          primary: primary ?? AppColors.primary,
          borderColor: primary ?? AppColors.primary,
          elevation: elevation ?? 0,
          surface: Colors.grey,
        ),
        child: child ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon ?? Container(),
                Padding(
                  padding: EdgeInsets.only(
                    left: icon != null ? 10 : 0,
                    right: suffix != null ? 10 : 0,
                  ),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: textColor ?? Colors.white,
                          fontWeight: weight ?? FontWeight.normal,
                          fontSize: fontsize ?? 17,
                          decoration: decoration,
                          fontFamily: font ?? AppStrings.font,
                        ),
                  ),
                ),
                suffix ?? Container(),
              ],
            ),
      ),
    );
  }
}

class CustomIconTextButton extends StatelessWidget {
  const CustomIconTextButton({
    Key? key,
    this.icon,
    required this.title,
    this.color,
    this.fontsize,
    this.weight,
    this.onpressed,
  }) : super(key: key);
  final Widget? icon;
  final String title;
  final Color? color;
  final double? fontsize;
  final FontWeight? weight;
  final VoidCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onpressed ?? () {},
      icon: icon ?? Icon(Icons.add, color: color ?? AppColors.primary),
      label: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: fontsize ?? 15,
              fontWeight: weight ?? FontWeight.bold,
              color: color ?? AppColors.primary,
            ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.title,
    this.color,
    this.fontsize,
    this.weight,
    this.onpressed,
    this.decoration,
  }) : super(key: key);
  final String title;
  final Color? color;
  final double? fontsize;
  final FontWeight? weight;
  final VoidCallback? onpressed;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpressed ?? () {},
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: fontsize ?? 17,
              fontWeight: weight ?? FontWeight.normal,
              color: color ?? AppColors.primary,
              decoration: decoration ?? TextDecoration.none,
            ),
      ),
    );
  }
}
