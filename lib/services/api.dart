import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather/enums/view_state.dart';
import 'package:flutter_weather/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiBaseUrl = "api.weatherapi.com";
const String forecast = "/v1/forecast.json";

class API {
  const API({
    this.latitude,
    this.longitude,
    required this.setState,
    required this.q,
    required this.setError,
  });

  final double? latitude;
  final double? longitude;
  final void Function(ViewState) setState;
  final String q;
  final void Function(String) setError;

  Future<WeatherModel> fetchWeather() async {
    setState(ViewState.LOADING);

    try {
      final uri = Uri.https(
        apiBaseUrl,
        forecast,
        {"key": dotenv.env["WEATHER_API_KEY"], "q": q, "days": 5}.map(
          (key, value) => MapEntry(
            key,
            value.toString(),
          ),
        ),
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        setState(ViewState.SUCCESS);
        return WeatherModel.fromJson(jsonDecode(response.body));
      } else {
        setError('Please enter a valid city 🧐');
        throw Exception("City doesn't exist!");
      }
    } catch (err) {
      // setError("Something went wrong!");
      setState(ViewState.ERROR);
      throw Exception(err);
    }
  }
}
