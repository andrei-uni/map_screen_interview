import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_screen_interview/app_colors.dart';
import 'package:map_screen_interview/map_screen/bottom_sheet/bottom_sheet_widget.dart';
import 'package:map_screen_interview/map_screen/detail_marker_widget.dart';
import 'package:map_screen_interview/map_screen/marker_widget.dart';
import 'package:map_screen_interview/models/marker_info.dart';
import 'package:map_screen_interview/map_screen/asset_button_widget.dart';
import 'package:map_screen_interview/map_screen/map_bloc/map_bloc.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.centerRight,
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: const LatLng(55.75, 37.62),
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                ),
                onMapReady: () {
                  context.read<MapBloc>().add(ControllerInited(_mapController));
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.map_screen_interview',
                ),
                // our own location
                BlocConsumer<MapBloc, MapState>(
                  listener: _stateChanged,
                  buildWhen: (previous, current) {
                    return previous.myCoordinates != current.myCoordinates;
                  },
                  builder: (context, state) {
                    return MarkerLayer(
                      alignment: Alignment.center,
                      markers: [
                        if (state.myCoordinates != null)
                          Marker(
                            point: state.myCoordinates!.toLatLng(),
                            width: 40,
                            height: 40,
                            child: Image.asset('assets/ic_my_tracker_46dp.png'),
                          ),
                      ],
                    );
                  },
                ),
                // markers
                BlocBuilder<MapBloc, MapState>(
                  buildWhen: (previous, current) {
                    return previous.markers != current.markers;
                  },
                  builder: (context, state) {
                    return MarkerClusterLayerWidget(
                      options: MarkerClusterLayerOptions(
                        maxClusterRadius: 45,
                        size: const Size(40, 40),
                        padding: const EdgeInsets.all(50),
                        maxZoom: 15,
                        markers: [
                          for (final MarkerInfo markerInfo in state.markers)
                            Marker(
                              point: markerInfo.coordinates.toLatLng(),
                              alignment: Alignment.topCenter,
                              width: 80,
                              height: 80,
                              child: MarkerWidget(
                                markerInfo: markerInfo,
                                onTap: () {
                                  _markerTapped(markerInfo, context);
                                },
                              ),
                            ),
                        ],
                        builder: (context, markers) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.blue,
                            ),
                            child: Center(
                              child: Text(
                                markers.length.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                // detail info markers
                BlocBuilder<MapBloc, MapState>(
                  buildWhen: (previous, current) {
                    return previous.markers != current.markers;
                  },
                  builder: (context, state) {
                    return MarkerClusterLayerWidget(
                      options: MarkerClusterLayerOptions(
                        maxClusterRadius: 100,
                        markers: [
                          for (final MarkerInfo markerInfo in state.markers)
                            Marker(
                              point: markerInfo.coordinates.toLatLng(),
                              alignment: Alignment.centerRight,
                              width: 140,
                              height: 85,
                              child: DetailMarkerWidget(markerInfo: markerInfo),
                            ),
                        ],
                        builder: (context, markers) {
                          return const SizedBox.shrink();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            // side buttons
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AssetButtonWidget(
                  asset: 'assets/ic_zoom_plus_55dp.png',
                  onPressed: () {
                    context.read<MapBloc>().add(ZoomIn());
                  },
                ),
                AssetButtonWidget(
                  asset: 'assets/ic_zoom_minus_55dp.png',
                  onPressed: () {
                    context.read<MapBloc>().add(ZoomOut());
                  },
                ),
                AssetButtonWidget(
                  asset: 'assets/ic_mylocation_55dp.png',
                  onPressed: () {
                    context.read<MapBloc>().add(UseMyLocation());
                  },
                ),
                AssetButtonWidget(
                  asset: 'assets/ic_next_tracker_55dp.png',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _stateChanged(BuildContext context, MapState state) {
    if (state.messageToShow != null) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(state.messageToShow!)),
        );
    }
  }

  void _markerTapped(MarkerInfo markerInfo, BuildContext context) {
    showBottomSheet(
      context: context,
      shape: const Border(),
      builder: (context) {
        return BottomSheetWidget(
          markerInfo: markerInfo,
        );
      },
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
