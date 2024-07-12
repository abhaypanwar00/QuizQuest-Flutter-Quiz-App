import 'package:flutter/material.dart';
import 'package:quizz/src/constant/colors.dart';

class TextForm extends StatefulWidget {
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const TextForm({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    required this.focusNode,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
    this.validator,
  });

  @override
  TextFormState createState() => TextFormState();
}

class TextFormState extends State<TextForm> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          setState(() {
            _obscureText = widget.obscureText;
          });
        }
      },
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        obscureText: _obscureText,
        onChanged: widget.onChanged,
        validator: widget.validator,
        cursorColor: appSecondaryColor,
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: Icon(
            widget.prefixIcon,
            color: widget.focusNode.hasFocus ? appSecondaryColor : Colors.grey,
          ),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: widget.focusNode.hasFocus
                        ? appSecondaryColor
                        : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          labelStyle: TextStyle(
            color: widget.focusNode.hasFocus ? appSecondaryColor : Colors.grey,
            fontWeight:
                widget.focusNode.hasFocus ? FontWeight.bold : FontWeight.w500,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              width: 2,
              color: appSecondaryColor,
            ),
          ),
        ),
        onTap: () {
          setState(() {
            widget.focusNode.requestFocus();
          });
        },
      ),
    );
  }
}
