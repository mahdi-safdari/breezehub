import 'package:geolocator/geolocator.dart';

class GetCurrentLocation {
  static final Geolocator geolocator = Geolocator();

  static Future<bool> hasPermissionLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return false;
    } else {
      return true;
    }
  }

  static Future<Position> getCurrentPosition() async {
    final bool hasPermission = await hasPermissionLocation();
    if (hasPermission) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position;
    } else {
      throw Exception('Permission not granted');
    }
  }
}
