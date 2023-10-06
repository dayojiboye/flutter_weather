import 'package:flutter/material.dart';
import 'package:flutter_weather/utils/theme.dart';
import 'package:geolocator/geolocator.dart';

class LocationError extends StatelessWidget {
  const LocationError({required this.errorMessage, super.key});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: kWhite,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 48,
            width: 200,
            child: TextButton(
              onPressed: () async {
                await Geolocator.openLocationSettings();
              },
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              child: const Text(
                "Enable location",
                style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
