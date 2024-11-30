import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mechanix_admin/helpers/custom_text.dart';
import 'package:mechanix_admin/helpers/reusable_container.dart';

import 'responsive_widget.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double? fontSize;
  bool isLoading;

  CustomButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.width,
    this.textColor,
    required this.backgroundColor,
    this.borderColor,
    this.height,
    this.fontSize,
    required this.isLoading, 
  });

  @override
  Widget build(BuildContext context) {
    return ReUsableContainer(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      verticalPadding: context.height * 0.01,
      height: height ?? 50,
      width: width,
      color: backgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Center(
            child: isLoading
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SpinKitRing(
                      lineWidth: 2.0,
                      color: Colors.white70,
                    ),
                  )
                : CustomTextWidget(
                    text: buttonText,
                    fontSize:Responsive.isMobile(context) ? fontSize ?? 14 : 16,
                    textColor: textColor,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  )),
      ),
    );
  }
}
