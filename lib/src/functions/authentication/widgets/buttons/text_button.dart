import 'package:flutter/material.dart';

class TextBtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final double? fontSize;
  final Color color;
  final bool wantIcon;

  const TextBtn({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    this.icon,
    this.fontSize,
    required this.wantIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: const ButtonStyle(
        splashFactory: NoSplash.splashFactory,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (wantIcon)
            Icon(
              icon,
              color: color,
              size: 25,
            ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: fontSize ?? 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
