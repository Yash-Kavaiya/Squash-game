import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AchievementsScreen extends StatelessWidget {
  final SquashTheme d;
  const AchievementsScreen({super.key, required this.d});

  @override
  Widget build(BuildContext context) {
    final items = [
      _Ach('First Win', 'Won your first match', true, '★'),
      _Ach('Drive Master', '500 drives landed', true, '➜'),
      _Ach('Tin Avoider', '20 rallies, 0 tins', true, '◆'),
      _Ach('Streak 10', 'Win 10 matches in a row', false, '⚡', 70),
      _Ach('Iron Wrist', 'Play 50 matches', false, '✦', 46),
      _Ach('Boast Boss', '100 boast winners', false, '↻', 22),
    ];

    return Scaffold(
      backgroundColor: d.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              color: d.chip,
              border: Border.all(color: d.line),
            ),
            child: Icon(Icons.arrow_back, size: 18, color: d.ink),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('PROGRESS · 14 / 40',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    letterSpacing: 2,
                    color: d.inkDim)),
            Text('Achievements',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: d.ink)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Progress ring
            SizedBox(
              width: 120,
              height: 120,
              child: CustomPaint(
                size: const Size(120, 120),
                painter: _RingPainter(progress: 14 / 40, primary: d.primary, chip: d.chip),
              ),
            ),
            Center(
              child: Text('14',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                      color: d.ink)),
            ),
            Center(
              child: Text('OF 40',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10,
                      color: d.inkDim,
                      letterSpacing: 1.5)),
            ),
            const SizedBox(height: 16),

            // Achievement grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.1,
              ),
              itemCount: items.length,
              itemBuilder: (context, i) => _achievementCard(items[i]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _achievementCard(_Ach a) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(d.rsm),
        color: a.got ? d.card : d.bgElev,
        border: Border.all(color: a.got ? d.primary : d.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: a.got ? d.primary : d.chip,
            ),
            child: Center(
              child: Text(a.icon,
                  style: TextStyle(
                      color: a.got ? d.primaryInk : d.inkMute,
                      fontSize: 18)),
            ),
          ),
          const SizedBox(height: 8),
          Text(a.title,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: d.ink)),
          const SizedBox(height: 2),
          Text(a.sub,
              style: TextStyle(fontSize: 10, color: d.inkDim)),
          if (!a.got && a.pct != null) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: Container(
                height: 3,
                color: d.chip,
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: a.pct! / 100,
                  child: Container(color: d.primary),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Ach {
  final String title, sub, icon;
  final bool got;
  final int? pct;
  _Ach(this.title, this.sub, this.got, this.icon, [this.pct]);
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color primary, chip;

  _RingPainter({required this.progress, required this.primary, required this.chip});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = 48.0;

    canvas.drawCircle(center, radius, Paint()..color = chip..strokeWidth = 10..style = PaintingStyle.stroke);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.5708,
      6.2832 * progress,
      false,
      Paint()..color = primary..strokeWidth = 10..style = PaintingStyle.stroke..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) => oldDelegate.progress != progress;
}
