import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '/components/animated_button.dart';

class SpinLine extends StatefulWidget {
  const SpinLine({super.key});

  @override
  SpinLineState createState() => SpinLineState();
}

class SpinLineState extends State<SpinLine> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  final random = Random();

  double startRotation = 0;
  double endRotation = 0;
  double rotation = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
    );

    controller.addListener(() {
      final t = controller.value;

      final transformed = Curves.decelerate.transform(t);

      rotation = lerpDouble(startRotation, endRotation, transformed)!;
    });
  }

  void spin() {
    final randomDuration = 1000 + random.nextInt(1500);

    startRotation = rotation;

    endRotation = startRotation + 8 * pi * random.nextDouble();

    controller.duration = Duration(milliseconds: randomDuration);

    controller.reset();
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return AnimatedButton(onTap: () {
            if (!controller.isAnimating) {
              spin();
            }
          }, childBuilder: (context, hover, pointerDown) {
            return Transform.rotate(
              angle: rotation,
              child: SvgPicture.asset('assets/svg/online_hvit_o.svg', height: 300),
            );
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
