import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quizz/src/constant/colors.dart';

class ResultImageContainer extends StatelessWidget {
  const ResultImageContainer({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 10,
      right: 10,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: const BoxDecoration(
          color: appPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Result",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              SvgPicture.asset(
                image,
                height: MediaQuery.of(context).size.height * 0.15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
