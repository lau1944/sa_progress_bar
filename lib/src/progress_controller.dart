
import 'package:flutter/cupertino.dart';

class ProgressController extends ChangeNotifier {

  ProgressController({double? progress, double? bufferProgress}) {
    _progress = progress ?? 0.0;
    _bufferProgress = bufferProgress ?? 0.0;
  }

  late double _progress;
  late double _bufferProgress;

  double get progress => _progress;
  double get bufferProgress => _bufferProgress;

  void moveTo(double progress) {
    _progress = progress;
    notifyListeners();
  }

  void moveBufferTo(double bufferProgress) {
    _bufferProgress = bufferProgress;
    notifyListeners();
  }

}