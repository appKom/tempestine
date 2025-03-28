import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../theme/themed_icon.dart';

class IconLabel extends StatelessWidget {
  final IconType icon;
  final String label;
  final Color color;
  final double fontSize;
  final int fontWeight;
  final double iconSize;

  final MainAxisAlignment alignment;

  IconLabel({
    super.key,
    required this.icon,
    required this.label,
    Color? color,
    this.fontSize = 16,
    this.iconSize = 20,
    this.fontWeight = 4,
    this.alignment = MainAxisAlignment.start,
  }) : color = color ?? OnlineTheme.current.fg;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: alignment,
      children: [
        ThemedIcon(icon: icon, size: iconSize, color: color),
        const SizedBox(width: 8),
        Text(
          label,
          style: OnlineTheme.textStyle(color: color, size: fontSize, weight: fontWeight),
          overflow: TextOverflow.visible,
        ),
      ],
    );
  }
}

// TODO: Technically compatible with all icons that use IconData. Come up with a better name.
class IconLabelLucide extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final double fontSize;
  final int fontWeight;
  final double iconSize;

  final MainAxisAlignment alignment;

  IconLabelLucide({
    super.key,
    required this.icon,
    required this.label,
    Color? color,
    this.fontSize = 16,
    this.iconSize = 20,
    this.fontWeight = 4,
    this.alignment = MainAxisAlignment.start,
  }) : color = color ?? OnlineTheme.current.fg;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: alignment,
      children: [
        Icon(icon, size: iconSize, color: color),
        const SizedBox(width: 8),
        Text(
          label,
          style: OnlineTheme.textStyle(color: color, size: fontSize, weight: fontWeight),
          overflow: TextOverflow.visible,
        ),
      ],
    );
  }
}
