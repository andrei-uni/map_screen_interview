import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_screen_interview/models/coordinates.dart';
import 'package:map_screen_interview/models/marker_info.dart';

part 'map_event.dart';
part 'map_state.dart';

const int _zoomStep = 1;

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc()
      : super(MapState(
          markers: <MarkerInfo>[],
          myCoordinates: null,
          messageToShow: null,
        )) {
    on<_LoadMarkers>(_onLoadMarkers);
    on<ControllerInited>(_onControllerInited);
    on<UseMyLocation>(_onUseMyLocation);
    on<ZoomIn>(_onZoomIn);
    on<ZoomOut>(_onZoomOut);

    add(_LoadMarkers());
  }

  MapController? _mapController;

  void _onLoadMarkers(_LoadMarkers event, Emitter<MapState> emit) {
    emit(state.copyWith(
      markers: [
        const MarkerInfo(
            name: 'Илья',
            asset: 'assets/man.jpg',
            coordinates: Coordinates(
              latitude: 55.75,
              longitude: 37.62,
            )),
        const MarkerInfo(
            name: 'Иван',
            asset: 'assets/man2.png',
            coordinates: Coordinates(
              latitude: 55.755,
              longitude: 37.625,
            )),
        const MarkerInfo(
            name: 'Александр',
            asset: 'assets/man.jpg',
            coordinates: Coordinates(
              latitude: 55.755,
              longitude: 37.629,
            )),
      ],
    ));
  }

  void _onControllerInited(ControllerInited event, Emitter<MapState> emit) {
    _mapController = event.mapController;
  }

  void _onUseMyLocation(UseMyLocation event, Emitter<MapState> emit) async {
    final locationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!locationEnabled) {
      _showMessage('Please enable geolocation', emit);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      
      if (permission == LocationPermission.denied) {
        _showMessage('Location permissions are denied', emit);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showMessage('Please enable geolocation for this app', emit);
      return;
    }

    final Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    final myCoordinates = Coordinates(
      latitude: currentPosition.latitude,
      longitude: currentPosition.longitude,
    );

    emit(state.copyWith(myCoordinates: myCoordinates));

    _mapController?.move(myCoordinates.toLatLng(), _mapController!.camera.zoom);
  }

  void _onZoomIn(ZoomIn event, Emitter<MapState> emit) {
    _mapController?.move(
      _mapController!.camera.center,
      _mapController!.camera.zoom + _zoomStep,
    );
  }

  void _onZoomOut(ZoomOut event, Emitter<MapState> emit) {
    _mapController?.move(
      _mapController!.camera.center,
      _mapController!.camera.zoom - _zoomStep,
    );
  }

  void _showMessage(String message, Emitter<MapState> emit) {
    emit(state.copyWith(messageToShow: () => message));
    emit(state.copyWith(messageToShow: () => null));
  }

  @override
  Future<void> close() {
    _mapController = null;
    return super.close();
  }
}
