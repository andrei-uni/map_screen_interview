import 'package:flutter/material.dart';
import 'package:map_screen_interview/app_colors.dart';

class IconTextBottomSheetWidget extends StatelessWidget {
  const IconTextBottomSheetWidget({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.blue,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
