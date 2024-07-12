import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quizz/src/constant/colors.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        Center(
          child: LoadingAnimationWidget.dotsTriangle(
            color: appSecondaryColor,
            size: 50,
          ),
        ),
      ],
    );
  }
}
