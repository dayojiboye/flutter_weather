import 'package:flutter/material.dart';
import 'package:flutter_weather/enums/view_state.dart';
import 'package:flutter_weather/models/weather_model.dart';
import 'package:flutter_weather/services/api.dart';
import 'package:flutter_weather/services/location.dart';
import 'package:flutter_weather/utils/theme.dart';
import 'package:flutter_weather/widgets/loading_indicator.dart';
import 'package:flutter_weather/widgets/location_error.dart';
import 'package:geolocator/geolocator.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool _isLocationLoading = true;
  String _locationError = "";
  late WeatherModel _weatherData;
  final TextEditingController _cityController = TextEditingController();
  ViewState _currentState = ViewState.IDLE;
  String _error = "";

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void _getWeather(double? latitude, double? longitude) async {
    WeatherModel data = await API(
        latitude: latitude,
        longitude: longitude,
        setState: (value) {
          setState(() {
            _currentState = value;
          });
        },
        q: _cityController.text.isNotEmpty
            ? _cityController.text
            : "$latitude,$longitude",
        setError: (err) {
          setState(() {
            _error = err;
          });
        }).fetchWeather();

    setState(() => _weatherData = data);
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await LocationService(
      context: context,
      setLocationError: (err) => setState(() => _locationError = err),
      setIsLocationLoading: () => setState(() => _isLocationLoading = false),
    ).handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _getWeather(position.latitude, position.longitude);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Widget? renderContent() {
    switch (_currentState) {
      case ViewState.LOADING:
        return const LoadingIndicator();

      case ViewState.ERROR:
        return Center(
          child: Text(_error),
        );

      case ViewState.SUCCESS:
        return Center(
          child: Text(_weatherData.location?.name ?? ""),
        );

      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          disabledColor: const Color.fromARGB(255, 114, 113, 113),
          onPressed: _isLocationLoading || _currentState == ViewState.LOADING
              ? null
              : () {},
          icon: const Icon(
            Icons.search,
            size: 32,
          ),
        ),
      ),
      body: _isLocationLoading
          ? const LoadingIndicator()
          : _locationError.isNotEmpty
              ? LocationError(errorMessage: _locationError)
              : renderContent(),
    );
  }
}
