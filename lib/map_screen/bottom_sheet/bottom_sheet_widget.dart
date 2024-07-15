import 'package:flutter/material.dart';
import 'package:map_screen_interview/app_colors.dart';
import 'package:map_screen_interview/map_screen/bottom_sheet/icon_text_bottom_sheet_widget.dart';
import 'package:map_screen_interview/models/marker_info.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    super.key,
    required this.markerInfo,
  });

  final MarkerInfo markerInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 25, bottom: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 43,
            backgroundColor: AppColors.blue,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(markerInfo.asset),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                markerInfo.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconTextBottomSheetWidget(
                    text: 'GPS',
                    icon: Icons.wifi,
                  ),
                  IconTextBottomSheetWidget(
                    text: '02.07.17',
                    icon: Icons.calendar_today_outlined,
                  ),
                  IconTextBottomSheetWidget(
                    text: '14:00',
                    icon: Icons.schedule,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.blue),
                ),
                child: const Text('Посмотреть историю'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
