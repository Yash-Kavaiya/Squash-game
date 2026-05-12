import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/court_view.dart';
import '../widgets/common_widgets.dart';

class PauseScreen extends StatelessWidget {
  final SquashTheme d;
  final List<int> score;
  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onQuit;

  const PauseScreen({
    super.key,
    required this.d,
    this.score = const [7, 4],
    required this.onResume,
    required this.onRestart,
    required this.onQuit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: d.bg,
      body: Stack(
        children: [
          // Court behind
          CourtView(
            d: d,
            W: MediaQuery.of(context).size.width,
            H: MediaQuery.of(context).size.height,
            ball: const BallState(x: 0.5, z: 0.5, y: 0.4),
            playerX: 0.5,
            oppX: 0.5,
          ),
          // Overlay blur
          Container(color: Colors.black.withOpacity(0.7)),

          // Content
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),

                // Game paused label
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('GAME 2 · PAUSED',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11,
                              letterSpacing: 2,
                              color: d.inkDim)),
                      GestureDetector(
                        onTap: onResume,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(99),
                            color: d.chip,
                            border: Border.all(color: d.line),
                          ),
                          child: const Icon(Icons.close, size: 14),
                        ),
                      ),
                    ],
                  ),
                ),

                // Score
                Center(
                  child: Text('${score[0]} — ${score[1]}',
                      style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 64,
                          fontWeight: FontWeight.w900,
                          color: Colors.white)),
                ),
                Text('YOU LEAD · BEST OF 5',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11,
                        letterSpacing: 2,
                        color: d.inkDim)),

                const SizedBox(height: 40),

                // Menu buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: onResume,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(d.r),
                            color: d.primary,
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.play_arrow, size: 20),
                                  const SizedBox(width: 10),
                                  Text('RESUME',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w800,
                                          fontSize: 17,
                                          letterSpacing: 0.5,
                                          color: d.primaryInk)),
                                ],
                              ),
                              Text('HOLD ↩',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 11,
                                      color: d.primaryInk
                                          .withOpacity(0.7))),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      RowBtn(
                          d: d,
                          icon: Icons.replay,
                          label: 'Restart game',
                          onTap: onRestart),
                      const SizedBox(height: 10),
                      RowBtn(
                          d: d,
                          icon: Icons.settings,
                          label: 'Settings'),
                      const SizedBox(height: 10),
                      RowBtn(
                          d: d,
                          icon: Icons.emoji_events,
                          label: 'Rules summary'),
                      const SizedBox(height: 10),
                      RowBtn(
                          d: d,
                          icon: Icons.close,
                          label: 'Quit match',
                          muted: true,
                          onTap: onQuit),
                    ],
                  ),
                ),

                const Spacer(),

                // Rally summary
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 18),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(d.r),
                      color: Colors.white.withOpacity(0.06),
                      border: Border.all(color: d.line),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('THIS GAME',
                            style: TextStyle(
                                fontSize: 11,
                                color: d.inkDim,
                                fontFamily: 'Inter',
                                letterSpacing: 1.5)),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            _stat('11', 'RALLIES', d.primary),
                            const SizedBox(width: 18),
                            _stat('4.2s', 'AVG RALLY', d.ink),
                            const SizedBox(width: 18),
                            _stat('2', 'TINS', d.warn),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String value, String label, Color accent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: accent)),
        Text(label,
            style: TextStyle(fontSize: 10, color: d.inkDim)),
      ],
    );
  }
}
