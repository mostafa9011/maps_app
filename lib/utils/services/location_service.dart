import 'dart:developer';
import 'package:location/location.dart';

class LocationService {
  static LocationService? _instance; //singleton
  static LocationService get instance {
    _instance ??= LocationService();
    return _instance!;
  }

  final _location = Location();
  // late PermissionStatus _permissionGranted;
  // late LocationData? locationData;

  Future<bool> checkAndEnableLocationService() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        log("location service is not enabled");
        return false;
      }
    }
    return true;
  }

  Future<bool> checkAndEnableLocationPerrmission() async {
    PermissionStatus permissionGranted = await _location.hasPermission();

    if (permissionGranted == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        log("location permission is not granted");
        return false;
      }
    }
    return true;
  }

  Future<LocationData?> getLocationDate() async {
    bool hasPermission = await checkAndEnableLocationPerrmission();
    if (hasPermission) {
      LocationData locationData = await _location.getLocation();
      log("location data: $locationData");
      return locationData;
    }
    return null;
  }

  getRealTimeLocationDate(void Function(LocationData)? onData) async {
    bool hasPermission = await checkAndEnableLocationPerrmission();
    if (hasPermission) {
      _location.onLocationChanged.listen(onData);
    }
  }

  Future<void> displayLocation() async {
    await checkAndEnableLocationService();
    await checkAndEnableLocationPerrmission();
    getLocationDate();
  }
}
