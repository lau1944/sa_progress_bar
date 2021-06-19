import 'package:flutter/cupertino.dart';

class ProgressBarView extends CustomPainter {
  final double progress;
  final double bufferProgress;
  final Color primaryColor;
  final Color bufferColor;
  final Color untouchedColor;
  final double indicatorSize;
  final double edgeRadius;
  final ValueChanged? onTap;
  final ValueChanged? onMoved;

  ProgressBarView(
      {required this.progress,
      required this.bufferProgress,
      required this.primaryColor,
      required this.bufferColor,
      required this.untouchedColor,
      required this.edgeRadius,
      required this.indicatorSize,
      this.onTap,
      this.onMoved});

  Offset? _indicatorOffset;
  Offset? _endOffset;
  Offset? _beginOffset;

  @override
  void paint(Canvas canvas, Size size) {
    final posHeight = size.height / 2;

    _beginOffset = Offset(0, posHeight);
    _endOffset = Offset(size.width, posHeight);
    _indicatorOffset = Offset(size.width * progress, posHeight);
    final Offset bufferOffset = Offset(size.width * bufferProgress, posHeight);

    // draw first layer line (init line)
    canvas.drawLine(
      _beginOffset!,
      _endOffset!,
      _linePainterFactory(untouchedColor, edgeRadius),
    );

    // draw buffer indicator line
    canvas.drawLine(
      _beginOffset!,
      bufferOffset,
      _linePainterFactory(bufferColor, edgeRadius),
    );

    // draw a indicator line
    canvas.drawLine(
      _beginOffset!,
      _indicatorOffset!,
      _linePainterFactory(primaryColor, edgeRadius),
    );

    // draw a circular indicator
    canvas.drawCircle(
      _indicatorOffset!,
      indicatorSize / 2,
      _circlePainterFactory(primaryColor, 0),
    );
  }

  Paint _linePainterFactory(Color color, double radius) => Paint()
    ..color = color
    ..strokeWidth = radius
    ..strokeCap = StrokeCap.round;

  Paint _circlePainterFactory(Color color, double radius) => Paint()
    ..color = color
    ..strokeWidth = radius
    ..style = PaintingStyle.fill;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool? hitTest(Offset position) {
    if (_beginOffset != null && _endOffset != null && _isInLine(position)) {
      if (onTap != null) onTap!(position.dx / _endOffset!.dx);
    }

    return super.hitTest(position);
  }

  bool _isInLine(
    Offset position,
  ) {
    return (position.dx > _beginOffset!.dx && position.dx < _endOffset!.dx) &&
        (position.dy > _beginOffset!.dy && position.dy < _endOffset!.dy);
  }
}
