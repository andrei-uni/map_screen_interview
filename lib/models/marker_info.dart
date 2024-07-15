import 'package:map_screen_interview/models/coordinates.dart';

class MarkerInfo {
  const MarkerInfo({
    required this.name,
    required this.asset,
    required this.coordinates,
  });

  final String name;
  final String asset;
  final Coordinates coordinates;
}
