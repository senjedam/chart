import 'package:flutter/material.dart';

class SShapedLinePainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final double cornerRadius;
  final double strokeWidth;
  final Color color;

  SShapedLinePainter({
    required this.start,
    required this.end,
    required this.cornerRadius,
    required this.strokeWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // var startY=start.dy-cornerRadius;
    var endY=end.dy-cornerRadius;//end x?????????????????????????????????????????
    // var endX=end.dx-cornerRadius;//end x?????????????????????????????????????????

    //direct line
    if(start.dx==end.dx){
      path.moveTo(start.dx, start.dy);
      path.lineTo(start.dx, end.dy);
    }
    // Determine the corner direction
    else if (start.dx <= end.dx && start.dy <= end.dy) {
      // Case 1: Start top-left, end bottom-right
      path.moveTo(start.dx, start.dy);
      path.lineTo(start.dx, endY - cornerRadius);
      path.arcToPoint(
        Offset(start.dx + cornerRadius, endY),
        radius: Radius.circular(cornerRadius),
        clockwise: false,
      );
      path.lineTo(end.dx-cornerRadius, endY);
      path.arcToPoint(
        Offset(end.dx, endY+cornerRadius),
        radius: Radius.circular(cornerRadius),
        clockwise: true,
      );
      // path.lineTo(end.dx+cornerRadius, endY+cornerRadius);
    }
    // else if (start.dx <= end.dx && start.dy > end.dy) {
    //   // Case 2: Start bottom-left, end top-right
    //   path.moveTo(start.dx, start.dy);
    //   path.lineTo(start.dx, end.dy + cornerRadius);
    //   path.arcToPoint(
    //     Offset(start.dx + cornerRadius, end.dy),
    //     radius: Radius.circular(cornerRadius),
    //     clockwise: true,
    //   );
    //   path.lineTo(end.dx, end.dy);
    // }
    else if (start.dx > end.dx && start.dy <= end.dy) {
      // Case 3: Start top-right, end bottom-left
      path.moveTo(start.dx, start.dy);
      path.lineTo(start.dx, endY - cornerRadius);
      path.arcToPoint(
        Offset(start.dx - cornerRadius, endY),
        radius: Radius.circular(cornerRadius),
        clockwise: true,
      );
      path.lineTo(end.dx+cornerRadius, endY);
      path.arcToPoint(
        Offset(end.dx , endY+cornerRadius),
        radius: Radius.circular(cornerRadius),
        clockwise: false,
      );
      // path.lineTo(end.dx-cornerRadius, endY+cornerRadius);
    }
    // else {
    //   // Case 4: Start bottom-right, end top-left
    //   path.moveTo(start.dx, start.dy);
    //   path.lineTo(start.dx, end.dy + cornerRadius);
    //   path.arcToPoint(
    //     Offset(start.dx - cornerRadius, end.dy),
    //     radius: Radius.circular(cornerRadius),
    //     clockwise: false,
    //   );
    //   path.lineTo(end.dx, end.dy);
    // }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
