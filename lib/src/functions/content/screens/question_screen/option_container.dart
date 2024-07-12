import 'package:flutter/material.dart';
import 'package:quizz/src/constant/colors.dart';

class OptionContainer extends StatelessWidget {
  final int index;
  final bool isSelected;
  final VoidCallback onTap;
  final String optionText;

  const OptionContainer({
    required this.index,
    required this.isSelected,
    required this.onTap,
    super.key,
    required this.optionText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: isSelected ? appSecondaryColor : Colors.transparent,
            width: 3,
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.circle_outlined,
                      size: 20,
                      color: isSelected ? appSecondaryColor : Colors.grey,
                    ),
                    if (isSelected)
                      const Icon(
                        Icons.circle,
                        size: 9,
                        color: appSecondaryColor,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                  child: Text(
                    optionText,
                    style: TextStyle(
                      color: isSelected ? appSecondaryColor : Colors.grey,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                    softWrap: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
