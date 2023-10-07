import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  const LocationService({
    required this.context,
    required this.setIsLocationLoading,
    required this.setLocationError,
  });

  final BuildContext context;
  final void Function() setIsLocationLoading;
  final void Function(String) setLocationError;

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setLocationError(
          'Location permission is off.\nEnable device location to get current weather of your city.\nOr you could search for a city.');
      setIsLocationLoading();
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setLocationError('Permission to access location was denied');
        setIsLocationLoading();
        return false;
      }
      // setLocationError('Permission to access location was denied');
      // setIsLocationLoading();
      // return false;
    }
    if (permission == LocationPermission.deniedForever) {
      setLocationError('Location permissions are permanently denied');
      setIsLocationLoading();
      return false;
    }
    setIsLocationLoading();
    return true;
  }
}
