import 'package:flutter/material.dart';
import 'package:flutter_weather/models/weather_model.dart';
import 'package:flutter_weather/utils/theme.dart';
import 'package:intl/intl.dart';

class ForecastTile extends StatelessWidget {
  const ForecastTile({required this.forecast, super.key});

  final Forecastday forecast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: kIconBg,
            radius: 40,
            child: Image.network("https:${forecast.day?.condition?.icon}"),
          ),
          const SizedBox(
            width: 24,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48),
                border: Border.all(
                  color: const Color.fromARGB(255, 231, 229, 229),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    forecast.day?.maxtempC.toString() ?? "",
                    style: const TextStyle(
                      color: kTextSecondary,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                  const Text(
                    "°C",
                    style: TextStyle(
                      color: kTextSecondary,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat("EEEE").format(
                          DateTime.parse(forecast.date!),
                        ),
                        style: const TextStyle(
                          color: kTextPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        DateFormat("d MMMM").format(
                          DateTime.parse(forecast.date!),
                        ),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 124, 123, 123),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
