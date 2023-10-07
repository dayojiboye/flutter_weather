import 'package:flutter/material.dart';
import 'package:flutter_weather/widgets/app_text_field.dart';
import 'package:flutter_weather/widgets/button.dart';

class CityBottomSheet extends StatefulWidget {
  const CityBottomSheet({
    required this.controller,
    required this.getWeather,
    super.key,
  });

  final TextEditingController controller;
  final Function(double? latitude, double? longitude) getWeather;

  @override
  State<CityBottomSheet> createState() => _CityBottomSheetState();
}

class _CityBottomSheetState extends State<CityBottomSheet> {
  bool _isButtonDisabled = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: widget.controller,
          hintText: "Enter city",
          onChanged: (value) {
            setState(() {
              _isButtonDisabled = value.trim().isEmpty;
              // print(value);
            });
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Button(
          label: "Submit",
          width: double.infinity,
          onPressed: _isButtonDisabled
              ? null
              : () {
                  widget.getWeather(null, null);
                  Navigator.of(context).pop();
                },
        )
      ],
    );
  }
}
