import 'package:flutter/material.dart';
import 'package:mechanix_admin/helpers/appcolors.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? textColor;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  int? maxLines;
  CustomTextWidget({
    super.key,
    required this.text,
    this.textColor,
    this.textAlign,
    this.fontSize,
    this.maxLines,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Poppins',
        decoration: decoration,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w300,
        color: textColor ?? AppColors.blueTextColor,
      ),
    );
  }
}
