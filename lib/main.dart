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
            const SizedBox(height: 30),

            const Text(
              'Task 2: Party Face Emoji',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              child: CustomPaint(
                painter: PartyFacePainter(),
                size: const Size(double.infinity, 250),
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              'Task 3: Blue Rounded Heart',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              child: CustomPaint(
                painter: BlueHeartPainter(),
                size: const Size(double.infinity, 250),
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              'Task 4: House with Balloons (Up! Emoji)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 350,
              child: CustomPaint(
                painter: HouseWithBalloonsPainter(),
                size: const Size(double.infinity, 350),
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
    final c = Offset(size.width / 2, size.height / 2);
    final p = Paint()..style = PaintingStyle.fill;

    // face
    p.color = Colors.yellow;
    canvas.drawCircle(c, 100, p);

    // eyes
    p.color = Colors.black;
    canvas.drawCircle(Offset(c.dx - 35, c.dy - 30), 15, p);
    canvas.drawCircle(Offset(c.dx + 35, c.dy - 30), 15, p);

    // smile
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

class PartyFacePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final p = Paint()..style = PaintingStyle.fill;

    // base yellow face
    p.color = Colors.yellow;
    canvas.drawCircle(c, 100, p);

    // eyes
    p.color = Colors.black;
    canvas.drawCircle(Offset(c.dx - 35, c.dy - 30), 15, p);
    canvas.drawCircle(Offset(c.dx + 35, c.dy - 30), 15, p);

    // smile
    final smile = Rect.fromCircle(center: c, radius: 70);
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawArc(smile, 0.1 * pi, 0.8 * pi, false, smilePaint);

    // party hat – taller tip
    p.color = Colors.purple;
    final hat = Path()
      ..moveTo(c.dx - 60, c.dy - 100)
      ..lineTo(c.dx + 60, c.dy - 100)
      ..lineTo(c.dx, c.dy - 260) // taller hat tip
      ..close();
    canvas.drawPath(hat, p);

    // Enhanced random confetti
    final rand = Random();
    final confettiColors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.pink,
      Colors.teal,
      Colors.deepPurple,
    ];

    for (int i = 0; i < 20; i++) {
      final color = confettiColors[rand.nextInt(confettiColors.length)];
      p.color = color;

      final dx = c.dx + rand.nextDouble() * 200 - 100;
      final dy = c.dy + rand.nextDouble() * 200 - 100;

      if (rand.nextBool()) {
        final radius = 3 + rand.nextDouble() * 4;
        canvas.drawCircle(Offset(dx, dy), radius, p);
      } else {
        final sizeSq = 6 + rand.nextDouble() * 4;
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset(dx, dy),
            width: sizeSq,
            height: sizeSq,
          ),
          p,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class BlueHeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final p = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // smoother, rounder heart using cubic Bézier curves
    final path = Path()
      ..moveTo(c.dx, c.dy + 40)
      ..cubicTo(c.dx + 100, c.dy - 20, c.dx + 60, c.dy - 140, c.dx, c.dy - 40)
      ..cubicTo(c.dx - 60, c.dy - 140, c.dx - 100, c.dy - 20, c.dx, c.dy + 40)
      ..close();

    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HouseWithBalloonsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height * 0.7);
    final p = Paint()..style = PaintingStyle.fill;

    // house base
    p.color = Colors.brown.shade400;
    final houseRect = Rect.fromCenter(center: c, width: 120, height: 100);
    canvas.drawRect(houseRect, p);

    // roof
    p.color = Colors.red.shade400;
    final roof = Path()
      ..moveTo(c.dx - 70, houseRect.top)
      ..lineTo(c.dx + 70, houseRect.top)
      ..lineTo(c.dx, houseRect.top - 70)
      ..close();
    canvas.drawPath(roof, p);

    // chimney
    final chimney = Rect.fromLTWH(c.dx + 25, houseRect.top - 50, 20, 40);
    p.color = Colors.grey.shade700;
    canvas.drawRect(chimney, p);

    // balloons
    final chimneyTop = Offset(chimney.left + 10, chimney.top);
    final balloonColors = [
      Colors.blue,
      Colors.green,
      Colors.pink,
      Colors.orange,
      Colors.purple,
    ];

    for (int i = 0; i < balloonColors.length; i++) {
      final angle = (i - 2) * 0.4; // spread balloons out
      final dx = chimneyTop.dx + cos(angle) * 60;
      final dy = chimneyTop.dy - sin(angle) * 80;

      // string
      p
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawLine(chimneyTop, Offset(dx, dy), p);

      // balloon
      p
        ..color = balloonColors[i]
        ..style = PaintingStyle.fill;
      canvas.drawOval(
        Rect.fromCenter(center: Offset(dx, dy), width: 40, height: 50),
        p,
      );
    }

    // house door
    p.color = Colors.black;
    canvas.drawRect(
      Rect.fromCenter(center: Offset(c.dx, c.dy + 20), width: 30, height: 50),
      p,
    );

    // house windows
    p.color = Colors.white;
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(c.dx - 35, c.dy - 10),
        width: 25,
        height: 25,
      ),
      p,
    );
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(c.dx + 35, c.dy - 10),
        width: 25,
        height: 25,
      ),
      p,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
