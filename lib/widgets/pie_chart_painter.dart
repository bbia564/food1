import 'dart:math' as math;
import 'package:flutter/material.dart';

class PieChartPainter extends CustomPainter {
  final List<double> values;
  final List<Color> colors;

  PieChartPainter({
    required this.values,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);

    double startAngle = 0.0;
    for (int i = 0; i < values.length; i++) {
      final sweepAngle = math.pi * 2 * (values[i] / sumList(values));
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill
        ..isAntiAlias = true;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true, // useCenter  
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
  double sumList(List<double> values) {
    double sum = 0.0;
    for (double value in values) {
      sum += value;
    }
    return sum;
  }
}