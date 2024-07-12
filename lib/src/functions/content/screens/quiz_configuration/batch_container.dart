import 'package:flutter/material.dart';
import 'package:quizz/src/constant/colors.dart';

class BatchContainer extends StatelessWidget {
  final String text;
  final bool isSelected;
  final double? width;
  final double? height;
  final VoidCallback onTap;

  const BatchContainer({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width * 0.13,
        height: height ?? MediaQuery.of(context).size.width * 0.12,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSelected ? appSecondaryColor : appPrimaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
