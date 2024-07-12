import 'package:flutter/material.dart';
import 'package:quizz/src/constant/colors.dart';

class OutlinedBtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? fontSize;

  const OutlinedBtn({
    super.key,
    required this.text,
    required this.onPressed,
    required this.width,
    required this.height,
    this.borderColor,
    this.backgroundColor,
    this.foregroundColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(width, height),
        splashFactory: NoSplash.splashFactory,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        foregroundColor: foregroundColor ?? appSecondaryColor,
        backgroundColor: backgroundColor ?? Colors.transparent,
        side: BorderSide(
          color: borderColor ?? appSecondaryColor,
          width: 3,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? MediaQuery.of(context).size.width * 0.05,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
