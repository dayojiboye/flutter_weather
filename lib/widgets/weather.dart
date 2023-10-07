import 'package:flutter/material.dart';
import 'package:flutter_weather/models/weather_model.dart';
import 'package:flutter_weather/utils/theme.dart';
import 'package:flutter_weather/widgets/forecast_tile.dart';

class Weather extends StatelessWidget {
  const Weather({required this.data, super.key});

  final WeatherModel data;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                data.location?.name ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: kWhite,
                ),
              ),
              Text(
                data.location?.country ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: kWhite,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Today's weather",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: kMuted,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https:${data.current?.condition?.icon}",
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                  Text(
                    "${data.current?.tempC.toString()}",
                    style: const TextStyle(
                      color: kWhite,
                      fontWeight: FontWeight.w700,
                      fontSize: 80,
                    ),
                  ),
                  const Text(
                    "°C",
                    style: TextStyle(
                      color: kWhite,
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Expanded(
                child: Forecast(
                  forecastData: data.forecast?.forecastday,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Forecast extends StatelessWidget {
  const Forecast({required this.forecastData, super.key});

  final List<Forecastday>? forecastData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.loose,
      children: [
        Positioned(
          top: 20,
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width / 1.2,
            decoration: const BoxDecoration(
              color: Color(0XFFBBB0F8),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(48),
                topRight: Radius.circular(48),
              ),
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            // height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(
              top: 40,
              left: 32,
              right: 32,
              bottom: 0,
            ),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Future Weather",
                  style: TextStyle(
                    color: kTextPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 50),
                    itemCount: forecastData!.length,
                    itemBuilder: (context, index) {
                      if (index < 1) return const SizedBox();
                      return ForecastTile(forecast: forecastData![index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
