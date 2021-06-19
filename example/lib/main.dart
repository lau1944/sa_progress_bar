import 'package:flutter/material.dart';
import 'package:sa_progress_bar/sa_progress_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: Container(
          height: 45,
          padding: EdgeInsets.symmetric(horizontal: 45),
          child: SaProgressBar(
            progress: progress,
            onMoved: (value) {
              setState(() {
                progress = value;
              });
            },
          ),
        ),
      ),
    );
  }
}

