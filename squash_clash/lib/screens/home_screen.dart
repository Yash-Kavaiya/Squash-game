import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/court_view.dart';
import '../widgets/common_widgets.dart';

class HomeScreen extends StatelessWidget {
  final SquashTheme d;
  final VoidCallback onStartGame;
  final Function(SquashTheme) onThemeChanged;

  const HomeScreen({
    super.key,
    required this.d,
    required this.onStartGame,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = d.id == 'court';
    return SafeArea(
      child: Stack(
        children: [
          // Court hero
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.44,
            child: Opacity(
              opacity: 0.95,
              child: Stack(
                children: [
                  CourtView(
                    d: d,
                    W: MediaQuery.of(context).size.width,
                    H: MediaQuery.of(context).size.height * 0.44,
                    ball: BallState(x: 0.55, z: 0.45, y: 0.3),
                    playerX: 0.4,
                    oppX: 0.6,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 80,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [d.bg.withOpacity(0), d.bg],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BrandMark(d: d),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => onThemeChanged(squashThemePace),
                        child: _themeDot(d.primary, d.id == 'pace'),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => onThemeChanged(squashThemeStadium),
                        child: _themeDot(squashThemeStadium.primary, d.id == 'stadium'),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => onThemeChanged(squashThemeCourt),
                        child: _themeDot(squashThemeCourt.primary, d.id == 'court'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Player card
          Positioned(
            top: MediaQuery.of(context).size.height * 0.36,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(d.r),
                color: isLight
                    ? Colors.white.withOpacity(0.92)
                    : const Color(0x0D141C1C).withOpacity(0.85),
                border: Border.all(color: d.lineStrong),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      gradient: LinearGradient(
                        colors: [d.primary, d.warn],
                      ),
                    ),
                    child: Center(
                      child: Text('MK',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800,
                              color: d.primaryInk,
                              fontSize: 18)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('WELCOME BACK',
                            style: TextStyle(
                                fontSize: 11,
                                color: d.inkDim,
                                fontFamily: 'Inter',
                                letterSpacing: 1.4)),
                        const SizedBox(height: 2),
                        Text('Mira K.',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: d.ink)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text('STREAK',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11,
                              color: d.inkDim,
                              letterSpacing: 1)),
                      Text('7',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: d.primary)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Quick Match button
          Positioned(
            top: MediaQuery.of(context).size.height * 0.52,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: onStartGame,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(d.r),
                  color: d.primary,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.play_arrow, size: 22),
                    const SizedBox(width: 10),
                    Text('QUICK MATCH',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                            color: d.primaryInk)),
                    const Spacer(),
                    Text('VS PRO AI',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: d.primaryInk.withOpacity(0.75))),
                  ],
                ),
              ),
            ),
          ),

          // Mode grid
          Positioned(
            top: MediaQuery.of(context).size.height * 0.64,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ModeCard(
                        d: d,
                        icon: Icons.track_changes,
                        title: 'Practice',
                        sub: 'Drills · Solo',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ModeCard(
                        d: d,
                        icon: Icons.people,
                        title: '2-Player',
                        sub: 'Local hot-seat',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ModeCard(
                        d: d,
                        icon: Icons.bar_chart,
                        title: 'Stats',
                        sub: 'Win 68% · 23 W',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ModeCard(
                        d: d,
                        icon: Icons.emoji_events,
                        title: 'Achievements',
                        sub: '14 / 40',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Theme label
          Positioned(
            top: 56,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: d.primary.withOpacity(0.2),
                ),
                child: Text(d.name.toUpperCase(),
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 9,
                        letterSpacing: 2,
                        color: d.primary)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _themeDot(Color color, bool active) {
    return Container(
      width: active ? 20 : 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(99),
        border: active
            ? Border.all(color: Colors.white, width: 2)
            : null,
      ),
    );
  }
}
