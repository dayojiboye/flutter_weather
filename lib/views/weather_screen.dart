import 'package:flutter/material.dart';
import 'package:flutter_weather/enums/view_state.dart';
import 'package:flutter_weather/models/weather_model.dart';
import 'package:flutter_weather/services/api.dart';
import 'package:flutter_weather/services/location.dart';
import 'package:flutter_weather/utils/theme.dart';
import 'package:flutter_weather/widgets/app_bottom_sheet.dart';
import 'package:flutter_weather/widgets/city_bottom_sheet.dart';
import 'package:flutter_weather/widgets/loading_indicator.dart';
import 'package:flutter_weather/widgets/location_error.dart';
import 'package:flutter_weather/widgets/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';

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
    // WidgetsBinding.instance.addObserver(this);
    _getCurrentPosition();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) _getCurrentPosition();
  // }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void _getWeather(double? latitude, double? longitude) async {
    setState(() {
      _locationError = "";
    });
    WeatherModel data = await API(
        latitude: latitude,
        longitude: longitude,
        setState: (value) {
          setState(() {
            _currentState = value;
          });
        },
        q: _cityController.text.isNotEmpty
            ? _cityController.text.trim()
            : latitude != null && longitude != null
                ? "$latitude,$longitude"
                : "",
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
      case ViewState.ERROR:
        return Center(
          child: Text(
            _error,
            style: const TextStyle(
              color: kWhite,
              fontSize: 18,
            ),
          ),
        );

      case ViewState.SUCCESS:
        return Weather(
          data: _weatherData,
        );

      default:
        return const LoadingIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackground,
      floatingActionButton:
          _isLocationLoading || _currentState == ViewState.LOADING
              ? null
              : FloatingActionButton(
                  backgroundColor: kTextSecondary,
                  disabledElevation: 0,
                  child: const Icon(
                    Iconsax.search_normal,
                    size: 32,
                  ),
                  onPressed: () {
                    AppBottomSheet(
                      context: context,
                      onDismiss: () => _cityController.clear(),
                      child: CityBottomSheet(
                        controller: _cityController,
                        getWeather: _getWeather,
                      ),
                    ).open();
                  },
                ),
      body: _isLocationLoading
          ? const LoadingIndicator()
          : _locationError.isNotEmpty
              ? LocationError(errorMessage: _locationError)
              : renderContent(),
    );
  }
}
