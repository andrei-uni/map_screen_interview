import 'package:flutter/material.dart';

class AssetButtonWidget extends StatelessWidget {
  const AssetButtonWidget({
    super.key,
    required this.asset,
    required this.onPressed,
  });

  final String asset;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Image.asset(asset),
    );
  }
}
