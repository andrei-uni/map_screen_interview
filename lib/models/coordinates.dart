import 'package:latlong2/latlong.dart';

// we dont wanna bring a third-party class (LatLng) into our domain layer
class Coordinates {
  const Coordinates({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  LatLng toLatLng() => LatLng(latitude, longitude);
}
