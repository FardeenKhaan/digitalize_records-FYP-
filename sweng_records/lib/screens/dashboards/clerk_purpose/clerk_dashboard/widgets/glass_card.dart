import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sweng_records/screens/dashboards/clerk_purpose/clerk_dashboard/widgets/style/decoration.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  const GlassCard({super.key, required this.child, this.padding = const EdgeInsets.all(20), this.borderRadius = 20});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: FkDecorations.glass(borderRadius: borderRadius),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(padding: padding, child: child),
        ),
      ),
    );
  }
}
