import 'package:flutter/material.dart';

class FkButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Gradient gradient;
  final Color foregroundColor;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  const FkButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.gradient = const LinearGradient(
      colors: [
        Color.fromARGB(255, 46, 57, 75),
        Color.fromARGB(255, 73, 99, 125),
        Color.fromARGB(255, 70, 94, 113),
        Color.fromARGB(255, 29, 45, 53),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    this.foregroundColor = Colors.white,
    this.fontSize = 18,
    this.padding = const EdgeInsets.symmetric(vertical: 14),
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(borderRadius)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: Colors.transparent, // 🔑 Transparent
          shadowColor: Colors.transparent, // 🔑 Remove shadow
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        ),
        onPressed: onPressed,
        child: Text(label, style: TextStyle(color: foregroundColor, fontSize: fontSize, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
