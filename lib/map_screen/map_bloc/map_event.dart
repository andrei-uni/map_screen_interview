part of 'map_bloc.dart';

sealed class MapEvent {}

final class _LoadMarkers extends MapEvent {}

final class ControllerInited extends MapEvent {
  ControllerInited(this.mapController);

  final MapController mapController;
}

final class UseMyLocation extends MapEvent {}

final class ZoomIn extends MapEvent {}

final class ZoomOut extends MapEvent {}
