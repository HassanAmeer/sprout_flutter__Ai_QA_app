import 'dart:io';
import 'package:flutter/material.dart';

import '../constants/icons.dart';

class CustomImageWidget extends StatelessWidget {
  const CustomImageWidget({
    Key? key,
    required this.image,
    this.fit,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);
  final String image;
  final BoxFit? fit;
  final double? height, width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return image == ''
        ? assetImage('assets/icons/loading.gif',
            height: height, width: width, fit: BoxFit.cover, color: color)
        : image.contains('assets/')
            ? assetImage(image,
                height: height, width: width, fit: fit, color: color)
            : image.contains('https:/')
                ? SizedBox(
                    height: height,
                    width: width,
                    child: FadeInImage(
                      fit: fit,
                      placeholder: const AssetImage('assets/icons/loading.gif'),
                      image: image.contains('https://')
                          ? NetworkImage(image)
                          : AssetImage(image) as ImageProvider,
                      imageErrorBuilder: (context, object, trace) =>
                          const Center(child: Icon(Icons.info_outline_rounded)),
                    ),
                  )
                : fileImage(image,
                    height: height, width: width, fit: fit, color: color);
  }
}

Image assetImage(
  String path, {
  double? width,
  double? height,
  BoxFit? fit,
  Color? color,
}) {
  return Image.asset(
    path,
    width: width,
    height: height,
    fit: fit,
    color: color,
  );
}

Image networkImage(
  String path, {
  double? width,
  double? height,
  BoxFit? fit,
  Color? color,
}) {
  return Image.network(
    path,
    width: width,
    height: height,
    fit: fit,
    color: color,
  );
}

Image fileImage(
  String path, {
  double? width,
  double? height,
  BoxFit? fit,
  Color? color,
}) {
  return Image.file(
    File(path),
    width: width,
    height: height,
    fit: fit,
    color: color,
  );
}

ImageProvider providerImage(String image) {
  return image == ''
      ? const AssetImage(AppIcons.logo)
      : image.contains('assets/')
          ? AssetImage(image)
          : image.contains('https://')
              ? NetworkImage(image)
              : FileImage(File(image)) as ImageProvider;
}
