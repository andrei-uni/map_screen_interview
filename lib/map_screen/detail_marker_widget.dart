import 'package:flutter/material.dart';
import 'package:map_screen_interview/models/marker_info.dart';

class DetailMarkerWidget extends StatelessWidget {
  const DetailMarkerWidget({
    super.key,
    required this.markerInfo,
  });

  final MarkerInfo markerInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 20),
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.3,
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            markerInfo.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Text('GPS, 14:00'),
        ],
      ),
    );
  }
}
