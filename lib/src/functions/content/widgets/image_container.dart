import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quizz/src/constant/colors.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
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
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: const BoxDecoration(
          color: appPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: appSecondaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Icon(
                    CupertinoIcons.back,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: SvgPicture.asset(
                image,
                height: MediaQuery.of(context).size.height * 0.15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
