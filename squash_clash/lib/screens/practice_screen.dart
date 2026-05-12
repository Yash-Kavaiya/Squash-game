import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/court_view.dart';

class PracticeScreen extends StatelessWidget {
  final SquashTheme d;
  const PracticeScreen({super.key, required this.d});

  @override
  Widget build(BuildContext context) {
    final drills = [
      _Drill('Straight Drives', 'Build the rail', '5 min', 'CORE', 80),
      _Drill('Boast & Drive', 'Movement loop', '8 min', 'PAIR', 45),
      _Drill('Front-Wall Only', 'Touch & feel', '4 min', 'SOLO', 60),
      _Drill('Serve Returns', 'Reactive depth', '6 min', 'CORE', 25),
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
            Text('PRACTICE',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    letterSpacing: 2,
                    color: d.inkDim)),
            Text('Sharpen up',
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
            // Featured drill
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(d.r),
                gradient: LinearGradient(
                  colors: [d.primary, d.warn],
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("TODAY'S FOCUS",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 10,
                              letterSpacing: 2,
                              color: d.primaryInk.withOpacity(0.75))),
                      const SizedBox(height: 8),
                      Text('Length & Width',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              height: 1.05,
                              color: d.primaryInk)),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                            '10 min · Build deep rails, then redirect cross-court.',
                            style: TextStyle(
                                fontSize: 13,
                                color: d.primaryInk.withOpacity(0.85))),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99),
                          color: d.primaryInk,
                        ),
                        child: Text('START ›',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w800,
                                fontSize: 12,
                                letterSpacing: 0.6,
                                color: d.primary)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // All drills
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ALL DRILLS',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11,
                        color: d.inkDim,
                        letterSpacing: 1.5)),
              ],
            ),
            const SizedBox(height: 8),
            ...drills.map((dr) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(d.rsm),
                    color: d.card,
                    border: Border.all(color: d.line),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: d.chip,
                        ),
                        child: Icon(Icons.track_changes,
                            size: 18, color: d.primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(dr.title,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: d.ink)),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(4),
                                    color: d.chip,
                                  ),
                                  child: Text(dr.tag,
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 9,
                                          color: d.inkDim,
                                          letterSpacing: 1)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text('${dr.sub} · ${dr.dur}',
                                style: TextStyle(
                                    fontSize: 11, color: d.inkDim)),
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(99),
                              child: Container(
                                height: 3,
                                color: d.chip,
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: dr.pct / 100,
                                  child: Container(color: d.primary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.chevron_right,
                          size: 16, color: d.inkDim),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _Drill {
  final String title, sub, dur, tag;
  final int pct;
  _Drill(this.title, this.sub, this.dur, this.tag, this.pct);
}
