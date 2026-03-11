import 'package:flutter/material.dart';

/// Creates a horizontal slide transition route.
/// [fromRight] = true  → new page slides in from the right (navigating to a higher tab index)
/// [fromRight] = false → new page slides in from the left  (navigating to a lower tab index)
PageRouteBuilder<T> slideRoute<T>({
  required Widget page,
  required bool fromRight,
}) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 280),
    reverseTransitionDuration: const Duration(milliseconds: 280),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final begin = Offset(fromRight ? 1.0 : -1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(
        begin: begin,
        end: end,
      ).chain(CurveTween(curve: Curves.easeInOut));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}
