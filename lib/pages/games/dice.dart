import 'dart:math';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '/components/animated_button.dart';
import '/components/online_scaffold.dart';
import '/theme/theme.dart';

class DicePage extends StaticPage {
  const DicePage({super.key});

  @override
  Widget content(BuildContext context) {
    return const StatefulDice();
  }
}

class StatefulDice extends StatefulWidget {
  const StatefulDice({super.key});

  @override
  StatefulDiceState createState() => StatefulDiceState();
}

class StatefulDiceState extends State<StatefulDice> with SingleTickerProviderStateMixin {
  int _diceRoll = 1;
  late AnimationController _animationController;
  final _random = Random();
  bool _isSimulator = false;
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  int _step = 0;
  int _direction = 1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animationController.addListener(_animate);
    _checkIfSimulator();
  }

  Future<void> _checkIfSimulator() async {
    if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      setState(() {
        _isSimulator = !iosInfo.isPhysicalDevice;
      });
    }
  }

  void _animate() {
    final t = Curves.easeOut.transform(_animationController.value);

    final i = (t * 5).ceil();

    if (i > _step) {
      setState(() {
        _step = i;
        _diceRoll = _random.nextInt(6) + 1;
      });
    }

    // Add heavy haptic feedback when animation completes and dice shows 6
    if (_animationController.isCompleted && _diceRoll == 6) {
      _triggerHeavyHaptic();
    }
  }

  void _triggerLightHaptic() {
    if (!_isSimulator) {
      HapticFeedback.lightImpact();
    }
  }

  void _triggerHeavyHaptic() {
    if (!_isSimulator) {
      HapticFeedback.heavyImpact();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void rollDice() {
    if (_animationController.isAnimating) return;

    // Add light haptic feedback when dice is tapped
    _triggerLightHaptic();

    _animationController.reset();
    _step = 0;
    _animationController.duration = Duration(milliseconds: 300 + Random().nextInt(700));
    _direction = Random().nextBool() ? 1 : -1;
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding + const EdgeInsets.symmetric(horizontal: 25);

    return Material(
      color: OnlineTheme.current.bg,
      child: Padding(
        padding: padding + EdgeInsets.symmetric(vertical: 64),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox.square(
                    dimension: 250,
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _direction * pi * 2 * Curves.decelerate.transform(_animationController.value),
                          child: AnimatedButton(
                            scale: 0.8,
                            onTap: rollDice,
                            childBuilder: (context, hover, pointerDown) {
                              return CustomPaint(
                                painter: DicePainter(repaint: _animationController, dice: _diceRoll),
                                size: const Size.square(200),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DicePainter extends CustomPainter {
  DicePainter({super.repaint, required this.dice});

  final int dice;

  @override
  void paint(Canvas canvas, Size size) {
    final dimension = min(size.width, size.height);
    final radius = dimension / 10;

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = OnlineTheme.current.fg;

    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, dimension, dimension), Radius.circular(radius)),
      paint,
    );

    paint.color = OnlineTheme.current.bg;

    final center = dimension / 2;
    final inset1 = (dimension / 5) + radius / 2;
    final inset2 = dimension - inset1;

    switch (dice) {
      case 1:
        canvas.drawCircle(Offset(center, center), radius, paint);
        break;
      case 2:
        canvas.drawCircle(Offset(inset1, inset2), radius, paint);
        canvas.drawCircle(Offset(inset2, inset1), radius, paint);
        break;
      case 3:
        canvas.drawCircle(Offset(center, center), radius, paint);
        canvas.drawCircle(Offset(inset1, inset2), radius, paint);
        canvas.drawCircle(Offset(inset2, inset1), radius, paint);
        break;
      case 4:
        canvas.drawCircle(Offset(inset1, inset1), radius, paint);
        canvas.drawCircle(Offset(inset2, inset1), radius, paint);
        canvas.drawCircle(Offset(inset1, inset2), radius, paint);
        canvas.drawCircle(Offset(inset2, inset2), radius, paint);
        break;
      case 5:
        canvas.drawCircle(Offset(center, center), radius, paint);
        canvas.drawCircle(Offset(inset1, inset1), radius, paint);
        canvas.drawCircle(Offset(inset2, inset1), radius, paint);
        canvas.drawCircle(Offset(inset1, inset2), radius, paint);
        canvas.drawCircle(Offset(inset2, inset2), radius, paint);
        break;
      default:
        canvas.drawCircle(Offset(inset1, inset1), radius, paint);
        canvas.drawCircle(Offset(inset1, center), radius, paint);
        canvas.drawCircle(Offset(inset1, inset2), radius, paint);
        canvas.drawCircle(Offset(inset2, inset1), radius, paint);
        canvas.drawCircle(Offset(inset2, center), radius, paint);
        canvas.drawCircle(Offset(inset2, inset2), radius, paint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
