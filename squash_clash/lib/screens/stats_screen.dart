import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/court_view.dart';

class StatsScreen extends StatelessWidget {
  final SquashTheme d;
  const StatsScreen({super.key, required this.d});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('LAST 30 DAYS',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11,
                            letterSpacing: 2,
                            color: d.inkDim)),
                    const SizedBox(height: 4),
                    Text('Your form',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: d.ink)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    color: d.chip,
                    border: Border.all(color: d.line),
                  ),
                  child: Text('MONTH ▾',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          color: d.ink)),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Stats grid
            Row(
              children: [
                Expanded(
                  flex: 14,
                  child: _bigStat('Win rate', '68%', d.primary, '+6'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 10,
                  child: _bigStat('Matches', '23', null, ''),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 10,
                  child: _bigStat('Streak', '7', d.warn, ''),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Sparkline chart
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(d.r),
                color: d.card,
                border: Border.all(color: d.line),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('WIN RATE',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11,
                              color: d.inkDim,
                              letterSpacing: 1)),
                      Text('68%',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11,
                              color: d.inkDim,
                              letterSpacing: 1)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  CustomPaint(
                    size: const Size(double.infinity, 120),
                    painter: _SparklinePainter(primary: d.primary, line: d.line),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('WK 1',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 10,
                              color: d.inkMute)),
                      Text('WK 2',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 10,
                              color: d.inkMute)),
                      Text('WK 3',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 10,
                              color: d.inkMute)),
                      Text('WK 4',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 10,
                              color: d.inkMute)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Shot breakdown
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(d.r),
                color: d.card,
                border: Border.all(color: d.line),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SHOT MIX',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          color: d.inkDim,
                          letterSpacing: 1)),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Row(
                      children: [
                        Expanded(flex: 42, child: Container(height: 16, color: d.primary)),
                        Expanded(flex: 24, child: Container(height: 16, color: d.warn)),
                        Expanded(flex: 18, child: Container(height: 16, color: d.good)),
                        Expanded(flex: 16, child: Container(height: 16, color: d.inkMute)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _legendDot(d.primary, 'Drive', '42%'),
                      const SizedBox(width: 12),
                      _legendDot(d.warn, 'Drop', '24%'),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _legendDot(d.good, 'Boast', '18%'),
                      const SizedBox(width: 12),
                      _legendDot(d.inkMute, 'Lob', '16%'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Recent matches
            Text('RECENT MATCHES',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    color: d.inkDim,
                    letterSpacing: 1.5)),
            const SizedBox(height: 8),
            _matchRow('Today', 'AI · Pro', 'W 3-1', true),
            _matchRow('Yesterday', 'Local 2P', 'W 3-2', true),
            _matchRow('Sun 11', 'AI · Pro', 'L 1-3', false),
          ],
        ),
      ),
    );
  }

  Widget _bigStat(String label, String value, Color? accent, String delta) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(d.r),
        color: d.card,
        border: Border.all(color: d.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(),
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  color: d.inkDim,
                  letterSpacing: 1.4)),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(value,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: accent ?? d.ink)),
              if (delta.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(delta,
                      style: TextStyle(
                          fontSize: 11,
                          color: d.good,
                          fontWeight: FontWeight.w600)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendDot(Color c, String l, String v) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: c)),
        const SizedBox(width: 6),
        Text(l, style: TextStyle(fontSize: 11, color: d.inkDim)),
        const SizedBox(width: 6),
        Text(v, style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: d.ink)),
      ],
    );
  }

  Widget _matchRow(String day, String opp, String score, bool won) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: d.line))),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: won ? d.primary : d.bad,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(opp, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: d.ink)),
                Text(day, style: TextStyle(fontSize: 11, color: d.inkDim)),
              ],
            ),
          ),
          Text(score,
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  color: won ? d.primary : d.bad)),
        ],
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final Color primary;
  final Color line;

  _SparklinePainter({required this.primary, required this.line});

  @override
  void paint(Canvas canvas, Size size) {
    final W = size.width, H = size.height;
    const pts = [80, 75, 90, 70, 60, 72, 55, 62, 40, 48, 32, 38, 28, 30, 22];

    // Grid lines
    for (int y = 20; y <= 80; y += 20) {
      canvas.drawLine(Offset(0, y * H / 100), Offset(W, y * H / 100), Paint()..color = line..strokeWidth = 1);
    }

    // Area fill
    final path = Path();
    path.moveTo(0, H);
    for (int i = 0; i < pts.length; i++) {
      final x = W * i / (pts.length - 1);
      final y = H * pts[i] / 100;
      path.lineTo(x, y);
    }
    path.lineTo(W, H);
    path.close();
    canvas.drawPath(path, Paint()..color = primary.withOpacity(0.2));

    // Line
    final linePath = Path();
    for (int i = 0; i < pts.length; i++) {
      final x = W * i / (pts.length - 1);
      final y = H * pts[i] / 100;
      if (i == 0) linePath.moveTo(x, y);
      else linePath.lineTo(x, y);
    }
    canvas.drawPath(linePath, Paint()..color = primary..strokeWidth = 2.5..style = PaintingStyle.stroke);

    // Dot at end
    final lastX = W;
    final lastY = H * pts.last / 100;
    canvas.drawCircle(Offset(lastX, lastY), 4, Paint()..color = primary);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) => false;
}
