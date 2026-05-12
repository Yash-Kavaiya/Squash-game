import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/court_view.dart';
import '../widgets/common_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  final SquashTheme d;
  const OnboardingScreen({super.key, required this.d});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _step = 1;

  final _steps = [
    {
      'eyebrow': '01 · CONTROLS',
      'title': 'Drag to move,\nflick up to smash.',
      'body':
          'Your finger is your racket. Slide along the bottom to position. Power scales with flick speed.',
    },
    {
      'eyebrow': '02 · THE TIN',
      'title': 'Hit above\nthe red line.',
      'body':
          'The bottom 19cm of the front wall is the tin. Below it = point lost. Aim high, drop deep.',
    },
    {
      'eyebrow': '03 · PAR 11',
      'title': 'First to 11,\nbest of 5.',
      'body':
          'Every rally is a point. At 10-10 the game extends until someone leads by two.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final s = _steps[(_step - 1) % 3];
    return Scaffold(
      backgroundColor: widget.d.bg,
      body: SafeArea(
        child: Stack(
          children: [
            // Top bar
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BrandMark(d: widget.d),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text('Skip',
                        style: TextStyle(
                            fontSize: 13, color: widget.d.inkDim)),
                  ),
                ],
              ),
            ),

            // Court illustration
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.42,
              child: CourtView(
                d: widget.d,
                W: MediaQuery.of(context).size.width,
                H: MediaQuery.of(context).size.height * 0.42,
                ball: BallState(x: 0.5, z: 0.25 + _step * 0.15, y: 0.5),
                playerX: 0.5,
                oppX: 0.5,
              ),
            ),

            // Content
            Positioned(
              top: MediaQuery.of(context).size.height * 0.58,
              left: 24,
              right: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s['eyebrow']!,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          letterSpacing: 2,
                          color: widget.d.primary)),
                  const SizedBox(height: 10),
                  Text(s['title']!,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 30,
                          height: 1.05,
                          fontWeight: FontWeight.w800,
                          color: widget.d.ink)),
                  const SizedBox(height: 12),
                  Text(s['body']!,
                      style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: widget.d.inkDim)),
                ],
              ),
            ),

            // Dots
            Positioned(
              bottom: 100,
              left: 24,
              child: Row(
                children: List.generate(3, (i) {
                  final active = i + 1 == _step;
                  return Container(
                    width: active ? 24 : 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      color: active ? widget.d.primary : widget.d.lineStrong,
                    ),
                  );
                }),
              ),
            ),

            // Buttons
            Positioned(
              bottom: 40,
              left: 24,
              right: 24,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (_step > 1) setState(() => _step--);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(widget.d.r),
                          color: widget.d.chip,
                          border: Border.all(color: widget.d.line),
                        ),
                        child: Center(
                          child: Text('Back',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: widget.d.ink)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        if (_step < 3) {
                          setState(() => _step++);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(widget.d.r),
                          color: widget.d.primary,
                        ),
                        child: Center(
                          child: Text(
                              _step == 3 ? 'START PRACTICE' : 'NEXT',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  letterSpacing: 0.5,
                                  color: widget.d.primaryInk)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
