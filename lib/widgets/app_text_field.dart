import 'package:flutter/material.dart';
import 'package:flutter_weather/utils/theme.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.controller,
    required this.hintText,
    this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: kMuted,
          ),
          borderRadius: BorderRadius.circular(2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(
            color: kMuted,
          ),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
