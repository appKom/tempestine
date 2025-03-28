import 'package:flutter/material.dart';

import '/theme/theme.dart';

class OnlineCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const OnlineCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: OnlineTheme.current.card,
        border: Border.all(color: OnlineTheme.current.border),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: child,
    );
  }
}
