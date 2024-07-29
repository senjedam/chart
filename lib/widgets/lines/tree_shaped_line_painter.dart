import 'package:flutter/material.dart';
import '../../constants/sizes.dart';

class TreeShapedLinePainter extends CustomPainter {
  final Offset start;
  final double strokeWidth;
  final Color color;
  final int nodeCount;

  TreeShapedLinePainter({
    required this.start,
    required this.strokeWidth,
    required this.color,
    required this.nodeCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double widgetHeight = ChartItemSizes.widgetHeight;
    double widgetPadding = ChartItemSizes.widgetPadding;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path();

    double totalY = (widgetHeight + widgetPadding / 2) * ((nodeCount / 2).ceil()-1) + widgetHeight / 2;
    path.moveTo(start.dx, start.dy);
    path.lineTo(start.dx, start.dy + totalY);
    for (int i = 0; i < (nodeCount / 2).floor(); i++) {
      double tempY =
          (i * (widgetHeight + widgetPadding / 2)) + (widgetHeight / 2);

      //left
      path.moveTo(start.dx, tempY);
      path.lineTo(start.dx - widgetPadding / 2, tempY);

      //right
      path.moveTo(start.dx, tempY);
      path.lineTo(start.dx + widgetPadding / 2, tempY);
    }
    if ((nodeCount % 2) != 0) {
      double tempY =
          ((nodeCount / 2).floor() * (widgetHeight + widgetPadding / 2)) +
              (widgetHeight / 2);
      path.moveTo(start.dx, tempY);
      path.lineTo(start.dx - widgetPadding / 2, tempY);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
