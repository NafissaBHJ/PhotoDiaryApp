import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  CurvePainter({required this.color});
  Color color;
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 0.5;
    var path = Path();
    path.moveTo(0, (80 * 0.9));
    path.quadraticBezierTo(
        size.width * 0.15, 80 * 0.25, size.width * 0.4, 80 * 0.367);
    path.quadraticBezierTo(
        size.width * 0.9, 80 * 0.55, size.width * 1.0, 80 * 0.372);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}