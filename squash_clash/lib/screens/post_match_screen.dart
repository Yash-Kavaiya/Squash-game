import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PostMatchScreen extends StatelessWidget {
  final SquashTheme d;
  const PostMatchScreen({super.key, required this.d});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: d.bg,
      body: SafeArea(
        child: Stack(
          children: [
            // Hero banner
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.36,
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [d.primary, d.warn],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text('MATCH · 12 MAY · 14:32',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11,
                                    letterSpacing: 2,
                                    color: d.primaryInk)),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 10),
                              child: const Icon(Icons.close,
                                  size: 12, color: Colors.white70),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Text('WIN.',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 56,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -1,
                                height: 0.95,
                                color: d.primaryInk)),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                              'You took the match 3–1 over Pro AI. Best rally of the day: 18 shots.',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: d.primaryInk
                                      .withOpacity(0.85))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Score breakdown
            Positioned(
              top: MediaQuery.of(context).size.height * 0.32,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(d.r),
                  color: d.card,
                  border: Border.all(color: d.line),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('YOU',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 11,
                                      color: d.inkDim,
                                      letterSpacing: 1.5)),
                              Text('3',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 40,
                                      fontWeight: FontWeight.w800,
                                      color: d.primary)),
                            ],
                          ),
                        ),
                        Text('vs',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                color: d.inkDim)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('AI · PRO',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 11,
                                      color: d.inkDim,
                                      letterSpacing: 1.5)),
                              Text('1',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 40,
                                      fontWeight: FontWeight.w800,
                                      color: d.ink)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ['11', '7'], ['9', '11'], ['11', '5'],
                        ['11', '8'], ['—', '—']
                      ].map((g) {
                        final won = g[0] != '—' &&
                            int.parse(g[0]) > int.parse(g[1]);
                        return Expanded(
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(d.rsm),
                              color: g[0] == '—'
                                  ? Colors.transparent
                                  : (won
                                      ? d.primary.withOpacity(0.08)
                                      : d.bad.withOpacity(0.08)),
                              border: Border.all(color: d.line),
                            ),
                            child: Column(
                              children: [
                                Text(g[0] == '—' ? '' : 'G${g[0] == '11' ? 1 : 2}',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: d.inkDim,
                                        letterSpacing: 1)),
                                Text('${g[0]}–${g[1]}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                        color: d.ink)),
                              ].where((w) => g[0] != '—' || w is! Text),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            // Stats bars
            Positioned(
              top: MediaQuery.of(context).size.height * 0.58,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  _statBar('Winners', 24, 17),
                  _statBar('Unforced errors', 9, 14, inverse: true),
                  _statBar('Longest rally', 18, 12, 'shots'),
                  _statBar('Avg power', 72, 68, '%'),
                ],
              ),
            ),

            // Bottom actions
            Positioned(
              bottom: 24,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(d.r),
                        color: d.chip,
                        border: Border.all(color: d.line),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.share, size: 14),
                          const SizedBox(width: 6),
                          Text('Share',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: d.ink)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(d.r),
                        color: d.primary,
                      ),
                      child: Center(
                        child: Text('REMATCH',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                letterSpacing: 0.5,
                                color: d.primaryInk)),
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

  Widget _statBar(String label, int you, int opp,
      {String unit = '', bool inverse = false}) {
    final total = (max(you, opp) * 1.2 + 1).toDouble();
    final winning = inverse ? you < opp : you > opp;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$you$unit',
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      color: winning ? d.primary : d.inkDim)),
              Text(label.toUpperCase(),
                  style: TextStyle(
                      fontSize: 11,
                      color: d.inkDim,
                      letterSpacing: 1)),
              Text('$opp$unit',
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Inter',
                      letterSpacing: 1,
                      color: d.inkDim)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: Container(
                    height: 6,
                    color: d.lineStrong,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FractionallySizedBox(
                        widthFactor: you / total,
                        child: Container(
                            color: winning
                                ? d.primary
                                : d.inkDim),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: Container(
                    height: 6,
                    color: d.lineStrong,
                    child: FractionallySizedBox(
                      widthFactor: opp / total,
                      child: Container(
                          color: !winning
                              ? d.bad
                              : d.inkDim),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
