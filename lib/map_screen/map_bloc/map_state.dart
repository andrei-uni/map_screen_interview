part of 'map_bloc.dart';

final class MapState {
  MapState({
    required this.markers,
    required this.myCoordinates,
    required this.messageToShow,
  });

  final List<MarkerInfo> markers;
  final Coordinates? myCoordinates;
  final String? messageToShow;

  MapState copyWith({
    List<MarkerInfo>? markers,
    Coordinates? myCoordinates,
    ValueGetter<String?>? messageToShow,
  }) {
    return MapState(
      markers: markers ?? this.markers,
      myCoordinates: myCoordinates ?? this.myCoordinates,
      messageToShow: messageToShow != null ? messageToShow() : this.messageToShow,
    );
  }
}
