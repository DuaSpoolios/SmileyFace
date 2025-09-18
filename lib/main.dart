import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const ShapesDemoApp());

class ShapesDemoApp extends StatelessWidget {
  const ShapesDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Custom Painter Demo',
      theme: ThemeData(useMaterial3: true),
      home: const MainTabs(),
    );
  }
}

//Tab added to add drop down menu
class MainTabs extends StatelessWidget {
  const MainTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Painter Demo'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All Tasks'),
              Tab(text: 'Pick Emoji'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ShapesDemoScreen(),   // original screen
            DropdownDemo(),       // new dropdown feature
          ],
        ),
      ),
    );
  }
}
// -----------------------------

class ShapesDemoScreen extends StatelessWidget {
  const ShapesDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task 1: Smiley Face',
              style: TextStyle(fontSize:20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              child: CustomPaint(
                painter: SmileyPainter(),
                size: const Size(double.infinity,250),
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              'Task 2: Party Face Emoji',
              style: TextStyle(fontSize:20, fontWeight: FontWeight.bold),
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
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              height: 250,
              decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFC1E3), Color(0xFFE91E63)], 
              ),
            ),
              child: CustomPaint(
                painter: BlueHeartPainter(),
                size: const Size(double.infinity,250),
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              'Task 4: House with Balloons (Up! Emoji + Rain Specks)',
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

    p.color = Colors.yellow;
    canvas.drawCircle(c, 100, p);

    p.color = Colors.black;
    canvas.drawCircle(Offset(c.dx - 35, c.dy - 30), 15, p);
    canvas.drawCircle(Offset(c.dx + 35, c.dy - 30), 15, p);

    final smile = Rect.fromCircle(center: c, radius: 70);
    final smilePaint = Paint()
      ..color= Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth= 8;
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

    p.color = Colors.yellow;
    canvas.drawCircle(c, 100, p);

    p.color = Colors.black;
    canvas.drawCircle(Offset(c.dx - 35, c.dy - 30), 15, p);
    canvas.drawCircle(Offset(c.dx + 35, c.dy - 30), 15, p);

    final smile = Rect.fromCircle(center: c, radius: 70);
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth=8;
    canvas.drawArc(smile, 0.1 * pi, 0.8 * pi, false, smilePaint);

    p.color = Colors.purple;
    final hat = Path()
      ..moveTo(c.dx - 60, c.dy - 100)
      ..lineTo(c.dx + 60, c.dy - 100)
      ..lineTo(c.dx, c.dy - 260) 
      ..close();
    canvas.drawPath(hat, p);

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

      final dx = c.dx + rand.nextDouble() * 200- 100;
      final dy = c.dy + rand.nextDouble() * 200- 100;

      if (rand.nextBool()) {
        final radius = 3 + rand.nextDouble() * 4;
        canvas.drawCircle(Offset(dx, dy), radius, p);
      } else {
        final sizeSq = 6 + rand.nextDouble() * 4;
        canvas.drawRect(
          Rect.fromCenter(center: Offset(dx, dy), width: sizeSq, height: sizeSq),
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
    final c = Offset(size.width/2, size.height/2);
    final p = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(c.dx, c.dy + 40)
      ..cubicTo(c.dx + 100, c.dy - 20, c.dx+ 60, c.dy - 140, c.dx, c.dy - 40)
      ..cubicTo(c.dx - 60, c.dy- 140, c.dx - 100, c.dy - 20, c.dx, c.dy + 40)
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

    final rand = Random();
    final rainPaint = Paint()
      ..color = Colors.lightBlue.shade300
      ..style = PaintingStyle.fill;
    for (int i = 0; i < 40; i++) {
      final x = rand.nextDouble() * size.width;
      final y = rand.nextDouble() * size.height;
      final radius = 1 + rand.nextDouble() * 2; 
      canvas.drawCircle(Offset(x,y), radius, rainPaint);
    }

    p.color = Colors.brown.shade400;
    final houseRect = Rect.fromCenter(center: c, width: 120, height: 100);
    canvas.drawRect(houseRect, p);

    p.color = Colors.red.shade400;
    final roof = Path()
      ..moveTo(c.dx - 70, houseRect.top)
      ..lineTo(c.dx + 70, houseRect.top)
      ..lineTo(c.dx, houseRect.top - 70)
      ..close();
    canvas.drawPath(roof, p);

    final chimney = Rect.fromLTWH(c.dx + 25, houseRect.top - 50, 20, 40);
    p.color = Colors.grey.shade700;
    canvas.drawRect(chimney, p);

    final chimneyTop = Offset(chimney.left+ 10, chimney.top);
    final balloonColors = [
      Colors.blue,
      Colors.green,
      Colors.pink,
      Colors.orange,
      Colors.purple,
    ];

    for (int i = 0; i < balloonColors.length; i++) {
      final angle = (i - 2) * 0.4; 
      final dx = chimneyTop.dx + cos(angle) * 60;
      final dy = chimneyTop.dy - sin(angle) * 80;

      p
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawLine(chimneyTop, Offset(dx, dy), p);

      p
        ..color = balloonColors[i]
        ..style = PaintingStyle.fill;
      canvas.drawOval(
        Rect.fromCenter(center: Offset(dx, dy), width: 40, height: 50),
        p,
      );
    }

    p.color = Colors.black;
    canvas.drawRect(
      Rect.fromCenter(center: Offset(c.dx, c.dy + 20), width: 30, height: 50),
      p,
    );

    p.color = Colors.white;
    canvas.drawRect(
      Rect.fromCenter(center: Offset(c.dx - 35, c.dy - 10), width: 25, height: 25),
      p,
    );
    canvas.drawRect(
      Rect.fromCenter(center: Offset(c.dx + 35, c.dy - 10), width: 25, height: 25),
      p,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// ---------- NEW DROPDOWN SCREEN ----------
class DropdownDemo extends StatefulWidget {
  const DropdownDemo({super.key});

  @override
  State<DropdownDemo> createState() => _DropdownDemoState();
}

class _DropdownDemoState extends State<DropdownDemo> {
  String selected = 'Smiley';

  CustomPainter getPainter() {
    switch (selected) {
      case 'Party Face': return PartyFacePainter();
      case 'Blue Heart': return BlueHeartPainter();
      case 'House': return HouseWithBalloonsPainter();
      default: return SmileyPainter();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButton<String>(
            value: selected,
            items: const [
              DropdownMenuItem(value: 'Smiley Face', child: Text('Smiley Face')),
              DropdownMenuItem(value: 'Party Face', child: Text('Party Face')),
              DropdownMenuItem(value: 'Blue Heart', child: Text('Blue Heart')),
              DropdownMenuItem(value: 'House', child: Text('House with Balloons and Rain')),
            ],
            onChanged: (val)=>setState(() => selected = val!),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: CustomPaint(
                painter: getPainter(),
                size: const Size(300, 300),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

