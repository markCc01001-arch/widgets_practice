import 'package:flutter/material.dart';

class IconLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? iconColor; // allow custom icon color
  final double iconSize; // allow custom size
  final FontWeight fontWeight;

  const IconLabel({
    super.key,
    required this.icon,
    required this.label,
    this.iconColor,
    this.iconSize = 18, // default size
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // keep compact
      children: [
        Icon(
          icon,
          size: iconSize,
          color: iconColor ?? Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: fontWeight),
        ),
      ],
    );
  }
}
