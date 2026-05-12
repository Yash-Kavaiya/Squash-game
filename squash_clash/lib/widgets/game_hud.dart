import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GameHUD extends StatelessWidget {
  final SquashTheme d;
  final List<int> score;
  final int gameNum;
  final double power;
  final bool swinging;
  final String? feedbackText;
  final String? feedbackKind;
  final String layout;

  const GameHUD({
    super.key,
    required this.d,
    this.score = const [0, 0],
    this.gameNum = 1,
    this.power = 0,
    this.swinging = false,
    this.feedbackText,
    this.feedbackKind,
    this.layout = 'classic',
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (layout == 'minimal') _buildMinimal() else if (layout == 'broadcast') _buildBroadcast() else _buildClassic(),
        if (feedbackText != null)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              child: Center(
                child: AnimatedOpacity(
                  opacity: feedbackText != null ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 700),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(d.rsm),
                      color: Colors.black54,
                      border: Border.all(
                        color: feedbackKind == 'good' ? d.primary : d.bad,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      feedbackText!,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                        fontSize: 28,
                        letterSpacing: 2,
                        color: feedbackKind == 'good' ? d.primary : d.bad,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildClassic() {
    return Stack(
      children: [
        Positioned(
          top: 14,
          left: 14,
          right: 14,
          child: Row(
            children: [
              _hudBtn('‖'),
              const Spacer(),
              _scoreBlock('YOU', score[0], d.primary),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text('G$gameNum/5',
                    style: TextStyle(
                        color: d.inkDim,
                        fontFamily: 'Inter',
                        fontSize: 11,
                        letterSpacing: 1)),
              ),
              _scoreBlock('AI', score[1], d.bad),
              const Spacer(),
              _hudBtn('⌕'),
            ],
          ),
        ),
        Positioned(
          bottom: 18,
          left: 14,
          right: 14,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('SWING POWER',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10,
                          letterSpacing: 1.5,
                          color: d.inkDim)),
                  const Spacer(),
                  Text('${(power * 100).round()}%',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10,
                          letterSpacing: 1.5,
                          color: d.inkDim)),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  height: 8,
                  color: Colors.white.withOpacity(0.08),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: power,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [d.primary, d.warn],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text('Drag to move · Flick up to smash',
                    style: TextStyle(fontSize: 11, color: d.inkDim)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMinimal() {
    return Stack(
      children: [
        Positioned(
          top: 14,
          left: 14,
          right: 14,
          child: Row(
            children: [
              Text('G$gameNum',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      color: d.inkDim,
                      letterSpacing: 1.5)),
              const Spacer(),
              Text('${score[0]}',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: d.primary)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('—',
                    style: TextStyle(
                        fontSize: 22, color: d.inkMute)),
              ),
              Text('${score[1]}',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: d.bad)),
              const Spacer(),
              _hudBtn('‖'),
            ],
          ),
        ),
        Positioned(
          bottom: 18,
          left: 14,
          right: 14,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 4,
              color: Colors.white.withOpacity(0.06),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: power,
                child: Container(
                  color: d.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBroadcast() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.7), Colors.transparent],
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: d.bad,
                      ),
                      child: Text('● LIVE',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: Colors.white,
                              letterSpacing: 1)),
                    ),
                    const Spacer(),
                    _hudBtn('‖'),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(d.rsm),
                    color: Colors.black54,
                    border: Border.all(color: d.lineStrong),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border(right: BorderSide(color: d.lineStrong)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('YOU',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: d.inkDim,
                                          letterSpacing: 1.4,
                                          fontFamily: 'Inter')),
                                  Text('${score[0]}',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 30,
                                          fontWeight: FontWeight.w800,
                                          color: d.ink)),
                                ],
                              ),
                              ...List.generate(5, (i) => Container(
                                width: 6,
                                height: 6,
                                color: i < gameNum ? d.primary : d.lineStrong,
                              )),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('AI · PRO',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: d.inkDim,
                                      letterSpacing: 1.4,
                                      fontFamily: 'Inter')),
                              Text('${score[1]}',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800,
                                      color: d.ink)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.7), Colors.transparent],
              ),
            ),
            child: Row(
              children: List.generate(16, (i) {
                final fill = i < (power * 16).round();
                Color c;
                if (!fill) {
                  c = Colors.white.withOpacity(0.06);
                } else if (i < 11) {
                  c = d.primary;
                } else if (i < 14) {
                  c = d.warn;
                } else {
                  c = d.bad;
                }
                return Expanded(
                  child: Container(
                    height: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    color: c,
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _hudBtn(String label) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(99),
        color: Colors.black54,
        border: Border.all(color: d.lineStrong),
      ),
      child: Center(
          child: Text(label,
              style: TextStyle(color: d.ink, fontSize: 16))),
    );
  }

  Widget _scoreBlock(String name, int score, Color accent) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(name,
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                letterSpacing: 1.6,
                color: d.inkDim)),
        Text('$score',
            style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w800,
                fontSize: 36,
                height: 1,
                color: accent)),
      ],
    );
  }
}
