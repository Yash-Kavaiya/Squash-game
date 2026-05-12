import 'package:flutter/material.dart';

class SquashTheme {
  final String id;
  final String name;
  final Color bg;
  final Color bgElev;
  final Color card;
  final Color cardHi;
  final Color line;
  final Color lineStrong;
  final Color ink;
  final Color inkDim;
  final Color inkMute;
  final Color primary;
  final Color primaryInk;
  final Color good;
  final Color bad;
  final Color warn;
  final Color courtFloor;
  final Color courtFloor2;
  final Color courtWall;
  final Color courtLine;
  final Color courtTin;
  final double r;
  final double rsm;
  final double rlg;
  final Color chip;

  const SquashTheme({
    required this.id,
    required this.name,
    required this.bg,
    required this.bgElev,
    required this.card,
    required this.cardHi,
    required this.line,
    required this.lineStrong,
    required this.ink,
    required this.inkDim,
    required this.inkMute,
    required this.primary,
    required this.primaryInk,
    required this.good,
    required this.bad,
    required this.warn,
    required this.courtFloor,
    required this.courtFloor2,
    required this.courtWall,
    required this.courtLine,
    required this.courtTin,
    this.r = 16,
    this.rsm = 10,
    this.rlg = 24,
    required this.chip,
  });
}

final squashThemePace = SquashTheme(
  id: 'pace',
  name: 'Pace',
  bg: const Color(0xFF0B0F10),
  bgElev: const Color(0xFF13191B),
  card: const Color(0xFF1B2224),
  cardHi: const Color(0xFF222B2D),
  line: Color(0x12FFFFFF),
  lineStrong: Color(0x24FFFFFF),
  ink: const Color(0xFFFFFFFF),
  inkDim: const Color(0xFFB4BCBE),
  inkMute: const Color(0xFF6E7779),
  primary: const Color(0xFFC6FF3D),
  primaryInk: const Color(0xFF0B1100),
  good: const Color(0xFF39E07B),
  bad: const Color(0xFFFF5151),
  warn: const Color(0xFFFFB23D),
  courtFloor: const Color(0xFF6B8E32),
  courtFloor2: const Color(0xFF5C7D2A),
  courtWall: const Color(0xFFE9E4D6),
  courtLine: const Color(0xFFC8392E),
  courtTin: const Color(0xFF1F1A14),
  r: 16,
  rsm: 10,
  rlg: 24,
  chip: Color(0x0FFFFFFF),
);

final squashThemeStadium = SquashTheme(
  id: 'stadium',
  name: 'Stadium',
  bg: const Color(0xFF0A0A0A),
  bgElev: const Color(0xFF111111),
  card: const Color(0xFF161616),
  cardHi: const Color(0xFF1E1E1E),
  line: Color(0x14FFFFFF),
  lineStrong: Color(0x2EFFFFFF),
  ink: const Color(0xFFFFFFFF),
  inkDim: const Color(0xFFA8A8A8),
  inkMute: const Color(0xFF6A6A6A),
  primary: const Color(0xFFFF4D14),
  primaryInk: const Color(0xFFFFFFFF),
  good: const Color(0xFF22D27A),
  bad: const Color(0xFFFF3B3B),
  warn: const Color(0xFFFFB100),
  courtFloor: const Color(0xFF8A5A2C),
  courtFloor2: const Color(0xFF724720),
  courtWall: const Color(0xFFE5DDC9),
  courtLine: const Color(0xFFFFFFFF),
  courtTin: const Color(0xFF1A1208),
  r: 4,
  rsm: 2,
  rlg: 8,
  chip: Color(0x14FFFFFF),
);

final squashThemeCourt = SquashTheme(
  id: 'court',
  name: 'Court',
  bg: const Color(0xFFF2EBDD),
  bgElev: const Color(0xFFFFFFFF),
  card: const Color(0xFFFFFFFF),
  cardHi: const Color(0xFFFAF5E9),
  line: Color(0x1414110D),
  lineStrong: Color(0x2E14110D),
  ink: const Color(0xFF14110D),
  inkDim: const Color(0xFF5A544A),
  inkMute: const Color(0xFF8B8579),
  primary: const Color(0xFFC8392E),
  primaryInk: const Color(0xFFFFFFFF),
  good: const Color(0xFF1F8A4C),
  bad: const Color(0xFFC8392E),
  warn: const Color(0xFFC7841F),
  courtFloor: const Color(0xFFD4B785),
  courtFloor2: const Color(0xFFC2A26A),
  courtWall: const Color(0xFFFFFFFF),
  courtLine: const Color(0xFFC8392E),
  courtTin: const Color(0xFF2A1F12),
  r: 20,
  rsm: 14,
  rlg: 28,
  chip: Color(0x0C14110D),
);

final allThemes = {
  'pace': squashThemePace,
  'stadium': squashThemeStadium,
  'court': squashThemeCourt,
};
