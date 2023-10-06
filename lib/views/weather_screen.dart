import 'package:flutter/material.dart';
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
  String? _currentAddress;
  Position? _currentPosition;
  bool _isLocationLoading = true;
  String _locationError = "";

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
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
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBackground,
        leading: IconButton(
          onPressed: () {},
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
              : null,
      // body: SafeArea(
      //   child: Padding(
      //     padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
      //     // child: Column(
      //     //   children: [
      //     //     // To-Do: create skeleton loader, use Future Builder to render views according to request state
      //     //     // Text(
      //     //     //   "Lat: ${_currentPosition?.latitude ?? ""}\nLong: ${_currentPosition?.longitude ?? ""}",
      //     //     //   style: const TextStyle(
      //     //     //     fontSize: 32,
      //     //     //     color: kWhite,
      //     //     //   ),
      //     //     // ),
      //     //   ],
      //     // ),
      //   ),
      // ),
    );
  }
}
