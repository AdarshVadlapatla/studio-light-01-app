import 'dart:math';

import 'package:flutter/material.dart';

class MovingDotsWidget extends StatefulWidget {
  @override
  _MovingDotsWidgetState createState() => _MovingDotsWidgetState();
}

class _MovingDotsWidgetState extends State<MovingDotsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int numberOfDots = 1000; // Number of dots equals to the number of degrees in a circle
  final double maxRadius = 150.0; // Adjust the maximum radius of the circle
  final double minRadius = 80.0; // Adjust the minimum radius of the circle
  late List<Offset> dotPositions;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat(reverse: true);

    _controller.addListener(() {
      setState(() {
        // Update dot positions on every animation frame
        dotPositions = List.generate(numberOfDots, (index) {
          double angle = 2 * pi * (index / numberOfDots);
          return _calculateDotPosition(angle, _controller.value);
        });
      });
    });

    // Initialize dot positions
    dotPositions = List.generate(numberOfDots, (index) {
      double angle = 2 * pi * (index / numberOfDots);
      return _calculateDotPosition(angle, _controller.value);
    });
  }

  Offset _calculateDotPosition(double angle, double animationValue) {
    final random = Random(); 
    final radiusDiff = maxRadius - minRadius; 
    final randomizer = random.nextInt((50).toInt());
    final random2 = Random();
    final randomizer2 = random2.nextDouble();
    final radius = minRadius +randomizer2* randomizer; // Adjusting radius based on animation value
    final centerX = 150.0; // Adjust the center X position
    final centerY = 150.0; // Adjust the center Y position

    final offsetX = centerX + radius * cos(angle);
    final offsetY = centerY + radius * sin(angle);

    return Offset(offsetX, offsetY);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MovingDotsPainter(dotPositions),
      size: Size(300, 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _MovingDotsPainter extends CustomPainter {
  final List<Offset> dotPositions;

  _MovingDotsPainter(this.dotPositions);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    dotPositions.forEach((position) {
      final random = Random(); 
      final dotSize = 0.4 + random.nextDouble() * .5; // Random dot size between 0.5 and 1   
      canvas.drawCircle(position, dotSize, paint);
    });
  }

  @override
  bool shouldRepaint(_MovingDotsPainter oldDelegate) => true;
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(child: MovingDotsWidget()),
    ),
  ));
}
