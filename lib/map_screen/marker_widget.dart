import 'package:flutter/material.dart';
import 'package:map_screen_interview/models/marker_info.dart';

class MarkerWidget extends StatelessWidget {
  const MarkerWidget({
    super.key,
    required this.markerInfo,
    required this.onTap,
  });

  final MarkerInfo markerInfo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: const FractionalOffset(0.5, 0.3),
        children: [
          Image.asset('assets/ic_tracker_75dp.png'),
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(markerInfo.asset),
          ),
        ],
      ),
    );
  }
}
