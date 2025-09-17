import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const ShapesDemoApp());

class ShapesDemoApp extends StatelessWidget {
  const ShapesDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Painter Demo',
      theme: ThemeData(useMaterial3: true),
      home: const ShapesDemoScreen(),
    );
  }
}

class ShapesDemoScreen extends StatelessWidget {
  const ShapesDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Painter Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task 1: Smiley Face',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              child: CustomPaint(
                painter: SmileyPainter(),
                size: const Size(double.infinity, 250),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SmileyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width/2, size.height/2);
    final p = Paint()..style = PaintingStyle.fill;

    //face
    p.color = Colors.yellow;
    canvas.drawCircle(c, 100, p);

    //eyes
    p.color = Colors.black;
    canvas.drawCircle(Offset(c.dx - 35, c.dy - 30), 15, p);
    canvas.drawCircle(Offset(c.dx + 35, c.dy - 30), 15, p);

    //smile
    final smile = Rect.fromCircle(center: c, radius: 70);
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawArc(smile, 0.1 * pi, 0.8 * pi, false, smilePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
