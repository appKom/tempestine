import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:go_router/go_router.dart';

import '/theme/theme.dart';

// Define the enum for navbar pages
enum NavbarPage {
  home,
  events,
  games,
  menu,
}

// Define a class for navbar buttons
class NavbarButton {
  final IconData icon;
  final void Function(BuildContext context)? onPressed;

  const NavbarButton({
    required this.icon,
    this.onPressed,
  });
}

// Define the navbar widget
class Navbar extends StatefulWidget {
  const Navbar({super.key});

  // Method to calculate navbar height
  static double height(BuildContext context) {
    final padding = MediaQuery.of(context).padding.bottom;
    return padding + 64;
  }

  @override
  State<Navbar> createState() => _NavbarState();
}

// State class for the navbar
class _NavbarState extends State<Navbar> {
  // Value notifier for the selected index
  static final ValueNotifier<int> _selected = ValueNotifier(0);

  // List of navbar buttons
  static final List<NavbarButton> _buttons = [
    NavbarButton(
      icon: LucideIcons.layout_list,
      onPressed: (context) => context.go('/'),
    ),
    NavbarButton(
      icon: LucideIcons.calendar_fold,
      onPressed: (context) => context.go('/calendar'),
    ),
    NavbarButton(
      icon: LucideIcons.dices,
      onPressed: (context) => context.go('/social'),
    ),
    NavbarButton(
      // icon: LucideIcons.menu,
      icon: LucideIcons.settings,
      onPressed: (context) => context.go('/menu'),
    ),
  ];

  // Method to create a navbar button widget
  Widget _navButton(int i, BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _selected,
      builder: (context, selected, child) {
        final active = i == selected;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            _buttons[i].onPressed?.call(context);
            _selected.value = i;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Icon(
              _buttons[i].icon,
              key: UniqueKey(),
              size: 24,
              color: active ? OnlineTheme.current.primary : OnlineTheme.current.fg,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: OnlineTheme.current.fg.withAlpha(25),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: OnlineTheme.current.fg.withAlpha(20)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                _buttons.length,
                (i) => _navButton(i, context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Static methods for setting active pages
class NavbarHelper {
  static void setActiveHome() {
    _NavbarState._selected.value = 0;
  }

  static void setActiveMenu() {
    _NavbarState._selected.value = 3;
  }
}
