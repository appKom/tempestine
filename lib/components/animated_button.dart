import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    super.key,
    this.onPressed,
    this.behavior = HitTestBehavior.deferToChild,
    required this.child,
  });

  final Widget child;
  final void Function()? onPressed;
  final HitTestBehavior behavior;

  @override
  State<StatefulWidget> createState() => AnimatedButtonState();
}

class AnimatedButtonState extends State<AnimatedButton> with TickerProviderStateMixin {
  bool down = false;

  void onPointerDown(PointerDownEvent evt) {
    setState(() {
      down = true;
    });
  }

  void onPointerUp(PointerUpEvent evt) {
    setState(() {
      down = false;
    });
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: widget.behavior,
      onPointerDown: onPointerDown,
      onPointerUp: onPointerUp,
      child: AnimatedScale(
        scale: down ? 0.8 : 1,
        duration: Duration(milliseconds: down ? 100 : 1000),
        alignment: Alignment.center,
        curve: down ? Curves.linear : Curves.elasticOut,
        child: widget.child,
      ),
    );
  }
}
