import 'package:flutter/material.dart';
import 'dart:math' as math;

class FluidBackgroundAnimation extends StatefulWidget {
  final Color color1;
  final Color color2;

  FluidBackgroundAnimation({
    this.color1 = const Color(0xFF4A90E2),
    this.color2 = const Color(0xFF50E3C2),
  });

  @override
  _FluidBackgroundAnimationState createState() => _FluidBackgroundAnimationState();
}

class _FluidBackgroundAnimationState extends State<FluidBackgroundAnimation> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _controller2 = AnimationController(
      duration: Duration(seconds: 15),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller1,
      builder: (context, child) {
        return CustomPaint(
          painter: FluidPainter(
            color1: widget.color1,
            color2: widget.color2,
            animation1: _controller1,
            animation2: _controller2,
          ),
          child: Container(),
        );
      },
    );
  }
}

class FluidPainter extends CustomPainter {
  final Color color1;
  final Color color2;
  final Animation<double> animation1;
  final Animation<double> animation2;

  FluidPainter({
    required this.color1,
    required this.color2,
    required this.animation1,
    required this.animation2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final path = Path();

    void addWave(double amplitude, double wavelength, double phase, double yOffset) {
      path.moveTo(0, size.height);
      for (double x = 0; x <= size.width; x++) {
        double y = amplitude * math.sin((x / wavelength) + phase) + yOffset;
        path.lineTo(x, y);
      }
      path.lineTo(size.width, size.height);
      path.close();
    }

    // First wave
    paint.color = color1;
    addWave(
      size.height * 0.2,
      size.width * 0.5,
      animation1.value * 2 * math.pi,
      size.height * 0.5,
    );
    canvas.drawPath(path, paint);

    // Second wave
    path.reset();
    paint.color = color2;
    addWave(
      size.height * 0.3,
      size.width * 0.7,
      animation2.value * 2 * math.pi,
      size.height * 0.6,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}