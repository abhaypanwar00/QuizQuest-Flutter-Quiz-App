import 'package:flutter/material.dart';
import 'package:quizz/src/constant/colors.dart';

class ElevatedBtn extends StatelessWidget {
  const ElevatedBtn({
    super.key,
    this.onPressed,
    required this.width,
    required this.height,
    this.loading = false,
    this.isIcon = false,
    this.text,
    this.icon,
  });

  final String? text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final bool loading;
  final bool isIcon;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: appSecondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(width, height),
        splashFactory: NoSplash.splashFactory,
      ),
      child: loading
          ? const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3.0,
              ),
            )
          : isIcon
              ? Icon(
                  icon,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.width * 0.07,
                )
              : Text(
                  text!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    color: Colors.white,
                  ),
                ),
    );
  }
}
