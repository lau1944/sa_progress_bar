import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sa_progress_bar/src/progress_bar_view.dart';
import 'package:sa_progress_bar/src/progress_controller.dart';

class SaProgressBar extends StatefulWidget {
  const SaProgressBar(
      {this.controller,
      this.initProgress = 0,
      this.indicatorSize = 15,
      this.primaryColor = Colors.blue,
      this.bufferColor = Colors.lightBlueAccent,
      this.untouchedColor = Colors.grey,
      this.largerWhenDrag = true,
      this.radius = 5,
      this.onTap,
      this.onMoved,
      Key? key})
      : super(key: key);

  /// indicator position progress (0.0 - 1.0)
  final double initProgress;

  /// buffer progress
  // Use [ProgressController] instead
  //final double bufferProgress;

  final ProgressController? controller;

  /// indicator size
  final double indicatorSize;

  /// the primary color
  final Color primaryColor;

  /// the color where buffer went
  final Color bufferColor;

  /// the color which stays untouched
  final Color untouchedColor;

  /// line edge border radius
  final double radius;

  /// Make indicator larger when dragging
  final bool largerWhenDrag;

  /// progress bar on tap
  final ValueChanged? onTap;

  /// indicator onMove callback
  final ValueChanged? onMoved;

  @override
  _SaProgressBarState createState() => _SaProgressBarState();
}

class _SaProgressBarState extends State<SaProgressBar> {
  late double _progress;
  late double _bufferProgress;
  late double _indicatorSize;

  /// give it acceptable offset for drag behavior,
  /// in case use drags to fast, the indicator cannot catch up
  final double _acceptableOffset = 20;
  bool isDragging = false;
  late final size;
  Offset? _indicatorOffset;
  Offset? _endOffset;

  late final ProgressController _controller;

  @override
  void initState() {
    _controller = widget.controller ?? ProgressController();
    _controller.moveTo(widget.initProgress);
    _attachListener();

    _progress = _controller.progress;
    _bufferProgress = _controller.bufferProgress;
    _indicatorSize = widget.indicatorSize;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _calculateOffset();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    //._controller.dispose();
    super.dispose();
  }

  void _attachListener() {
    _controller.addListener(() {
      if (mounted) {
        setState(() {
          _progress = _controller.progress;
          _bufferProgress = _controller.bufferProgress;
        });
      }
    });
  }

  void _calculateOffset() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      size = context.size;
      _indicatorOffset = Offset(size!.width * _progress, size.height / 2);
      _endOffset = Offset(size.width, size.height / 2);
    });
  }

  bool _isInIndicator(Offset position, Offset targetPosition) {
    double pX = position.dx;
    double pY = position.dy;
    double tX = targetPosition.dx;
    double tY = targetPosition.dy;

    if (pX < 0) return false;

    if (isDragging) return true;

    double _radius = widget.indicatorSize / 2 + _acceptableOffset;
    return (pX <= tX + _radius && pX >= tX - _radius) &&
        (pY <= tY + _radius && pY >= tY - _radius);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.indicatorSize,
      child: GestureDetector(
        onPanDown: _handleDragDown,
        onPanUpdate: _handleDragUpdate,
        onPanEnd: _handleDragEnd,
        child: CustomPaint(
          painter: ProgressBarView(
            progress: _progress,
            bufferProgress: _bufferProgress,
            primaryColor: widget.primaryColor,
            bufferColor: widget.bufferColor,
            untouchedColor: widget.untouchedColor,
            indicatorSize: _indicatorSize,
            edgeRadius: widget.radius,
            onTap: (value) {
              _controller.moveTo(value);
              if (widget.onTap != null) widget.onTap!(value);
            },
            onMoved: (value) {
              _controller.moveTo(value);
              if (widget.onMoved != null) widget.onMoved!(value);
            },
          ),
        ),
      ),
    );
  }

  void _handleDragDown(DragDownDetails details) {
    if (!isDragging &&
        _indicatorOffset != null &&
        _endOffset != null &&
        widget.onMoved != null &&
        _isInIndicator(details.localPosition, _indicatorOffset!)) {
      setState(() {
        isDragging = true;
        _indicatorSize += 5;
      });
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_indicatorOffset != null &&
        _endOffset != null &&
        widget.onMoved != null &&
        _isInIndicator(details.localPosition, _indicatorOffset!)) {
      final progress = details.localPosition.dx / _endOffset!.dx;
      if (progress >= 0 && progress <= 1) {
        _progress = progress;
        _indicatorOffset = Offset(size!.width * progress, size.height / 2);
        widget.onMoved!(progress);
      }
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (isDragging) {
      setState(() {
        _indicatorOffset = Offset(size!.width * _progress, size.height / 2);
        isDragging = false;
        _indicatorSize -= 5;
      });
    }
  }
}
