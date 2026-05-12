import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

Offset projectCourt(double W, double H, double x, double z,
    {double pad = 0.08}) {
  final backW = W * (1 - pad * 0.4);
  final frontW = W * (1 - pad * 1.6);
  final topY = H * 0.10;
  final botY = H * (1 - pad);
  final t = z;
  final rowW = backW * (1 - t) + frontW * t;
  final cx = W / 2;
  final sx = cx + (x - 0.5) * rowW;
  final sy = botY * (1 - t) + topY * t;
  return Offset(sx, sy);
}

class CourtView extends StatelessWidget {
  final SquashTheme d;
  final double W;
  final double H;
  final BallState? ball;
  final double playerX;
  final double oppX;
  final bool showLines;
  final bool showAvatars;
  final String perspective;

  const CourtView({
    super.key,
    required this.d,
    this.W = 360,
    this.H = 420,
    this.ball,
    this.playerX = 0.5,
    this.oppX = 0.5,
    this.showLines = true,
    this.showAvatars = true,
    this.perspective = 'iso',
  });

  @override
  Widget build(BuildContext context) {
    if (perspective == 'top') return _buildTopView();
    if (perspective == 'side') return _buildSideView();
    return _buildIsoView();
  }

  Widget _buildIsoView() {
    return CustomPaint(
      size: Size(W, H),
      painter: _CourtIsoPainter(
        d: d,
        ball: ball,
        playerX: playerX,
        oppX: oppX,
        showLines: showLines,
        showAvatars: showAvatars,
      ),
    );
  }

  Widget _buildTopView() {
    return CustomPaint(
      size: Size(W, H),
      painter: _CourtTopPainter(
        d: d,
        ball: ball,
        playerX: playerX,
        oppX: oppX,
        showLines: showLines,
        showAvatars: showAvatars,
      ),
    );
  }

  Widget _buildSideView() {
    return CustomPaint(
      size: Size(W, H),
      painter: _CourtSidePainter(
        d: d,
        ball: ball,
      ),
    );
  }
}

class BallState {
  final double x, z, y;
  BallState({this.x = 0.5, this.z = 0.1, this.y = 0.4});
}

class _CourtIsoPainter extends CustomPainter {
  final SquashTheme d;
  final BallState? ball;
  final double playerX, oppX;
  final bool showLines, showAvatars;

  _CourtIsoPainter({
    required this.d,
    this.ball,
    this.playerX = 0.5,
    this.oppX = 0.5,
    this.showLines = true,
    this.showAvatars = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final W = size.width, H = size.height;

    final bx0By0 = projectCourt(W, H, 0, 0);
    final bx1By1 = projectCourt(W, H, 1, 0);
    final fx0Fy0 = projectCourt(W, H, 0, 1);
    final fx1Fy1 = projectCourt(W, H, 1, 1);

    final fwallH = H * 0.36;
    final tinH = fwallH * 0.18;

    // Floor
    final floorPath = Path()
      ..moveTo(bx0By0.dx, bx0By0.dy)
      ..lineTo(bx1By1.dx, bx1By1.dy)
      ..lineTo(fx1Fy1.dx, fx1Fy1.dy)
      ..lineTo(fx0Fy0.dx, fx0Fy0.dy)
      ..close();
    final floorGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [d.courtFloor2, d.courtFloor],
    );
    canvas.drawPath(floorPath, Paint()..shader = floorGradient.createShader(Rect.fromLTWH(0, 0, W, H)));

    // Left wall
    final leftWallPath = Path()
      ..moveTo(bx0By0.dx, bx0By0.dy)
      ..lineTo(fx0Fy0.dx, fx0Fy0.dy)
      ..lineTo(fx0Fy0.dx, fx0Fy0.dy - fwallH)
      ..lineTo(bx0By0.dx, bx0By0.dy - fwallH * 1.1)
      ..close();
    canvas.drawPath(leftWallPath, Paint()..color = d.courtWall.withOpacity(0.75));

    // Right wall
    final rightWallPath = Path()
      ..moveTo(bx1By1.dx, bx1By1.dy)
      ..lineTo(fx1Fy1.dx, fx1Fy1.dy)
      ..lineTo(fx1Fy1.dx, fx1Fy1.dy - fwallH)
      ..lineTo(bx1By1.dx, bx1By1.dy - fwallH * 1.1)
      ..close();
    canvas.drawPath(rightWallPath, Paint()..color = d.courtWall.withOpacity(0.75));

    // Front wall
    final frontWallRect = Rect.fromLTWH(fx0Fy0.dx, fx0Fy0.dy - fwallH, fx1Fy1.dx - fx0Fy0.dx, fwallH);
    canvas.drawRect(frontWallRect, Paint()..color = d.courtWall);

    // Tin
    final tinRect = Rect.fromLTWH(fx0Fy0.dx, fx0Fy0.dy - tinH, fx1Fy1.dx - fx0Fy0.dx, tinH);
    canvas.drawRect(tinRect, Paint()..color = d.courtTin);
    // Tin line
    canvas.drawLine(
      Offset(fx0Fy0.dx, fx0Fy0.dy - tinH - 2),
      Offset(fx1Fy1.dx, fx0Fy0.dy - tinH - 2),
      Paint()..color = d.courtLine..strokeWidth = 2,
    );

    if (showLines) {
      final linePaint = Paint()..color = d.courtLine..strokeWidth = 1.5..style = PaintingStyle.stroke;

      // Service line on front wall
      canvas.drawLine(
        Offset(fx0Fy0.dx, fx0Fy0.dy - fwallH * 0.45),
        Offset(fx1Fy1.dx, fx0Fy0.dy - fwallH * 0.45),
        Paint()..color = d.courtLine..strokeWidth = 2,
      );

      // Out line on front wall
      canvas.drawLine(
        Offset(fx0Fy0.dx, fx0Fy0.dy - fwallH * 0.95),
        Offset(fx1Fy1.dx, fx0Fy0.dy - fwallH * 0.95),
        linePaint,
      );

      // Service box line
      final sbz = 0.35;
      final sb0 = projectCourt(W, H, 0, sbz);
      final sb1 = projectCourt(W, H, 1, sbz);
      canvas.drawLine(sb0, sb1, Paint()..color = d.courtLine..strokeWidth = 2);

      // Half court line
      final hcA = projectCourt(W, H, 0.5, 0);
      final hcB = projectCourt(W, H, 0.5, sbz);
      canvas.drawLine(hcA, hcB, Paint()..color = d.courtLine..strokeWidth = 2);

      // Side wall out lines
      canvas.drawLine(
        Offset(bx0By0.dx, bx0By0.dy - fwallH * 1.1),
        Offset(fx0Fy0.dx, fx0Fy0.dy - fwallH),
        linePaint,
      );
      canvas.drawLine(
        Offset(bx1By1.dx, bx1By1.dy - fwallH * 1.1),
        Offset(fx1Fy1.dx, fx1Fy1.dy - fwallH),
        linePaint,
      );
    }

    if (showAvatars) {
      final op = projectCourt(W, H, oppX, 0.55);
      final pp = projectCourt(W, H, playerX, 0.05);
      _drawAvatar(canvas, op.dx, op.dy, d.bad, 0.85);
      _drawAvatar(canvas, pp.dx, pp.dy, d.primary, 1.0);
    }

    if (ball != null) {
      final bp = projectCourt(W, H, ball!.x, ball!.z);
      final r = 7 + (1 - ball!.z) * 4;
      final lift = math.max(0, ball!.y) * 30;

      // Shadow
      canvas.drawOval(
        Rect.fromCenter(center: Offset(bp.dx, bp.dy + 2), width: r * 1.8, height: r * 0.7),
        Paint()..color = Colors.black45,
      );

      // Ball
      canvas.drawCircle(Offset(bp.dx, bp.dy - lift), r, Paint()..color = const Color(0xFF0B0B0B));
      canvas.drawCircle(Offset(bp.dx, bp.dy - lift), r, Paint()..color = d.primary..style = PaintingStyle.stroke..strokeWidth = 1.5);
    }
  }

  void _drawAvatar(Canvas canvas, double x, double y, Color tint, double scale) {
    final s = scale;
    canvas.save();
    canvas.translate(x - 16 * s, y - 70 * s);
    canvas.scale(s);

    // Shadow
    canvas.drawEllipse(Rect.fromCenter(center: const Offset(16, 68), width: 28, height: 7), Paint()..color = Colors.black38);
    // Body
    final bodyPath = Path()
      ..moveTo(16, 18)
      ..cubicTo(10, 18, 6, 23, 6, 30)
      ..lineTo(6, 48)
      ..cubicTo(6, 52, 8, 54, 10, 54)
      ..lineTo(22, 54)
      ..cubicTo(24, 54, 26, 52, 26, 48)
      ..lineTo(26, 30)
      ..cubicTo(26, 23, 22, 18, 16, 18)
      ..close();
    canvas.drawPath(bodyPath, Paint()..color = const Color(0xFF1a1a1a));

    // Shorts
    canvas.drawRect(Rect.fromLTWH(6, 48, 8, 16), Paint()..color = tint.withOpacity(0.9));
    canvas.drawRect(Rect.fromLTWH(18, 48, 8, 16), Paint()..color = tint.withOpacity(0.9));

    // Head
    canvas.drawCircle(const Offset(16, 10), 7, Paint()..color = const Color(0xFF3a2e23));

    // Racket arm
    final armX = 22.0;
    canvas.drawRect(Rect.fromLTWH(armX, 24, 10, 3.5), Paint()..color = const Color(0xFF1a1a1a));
    canvas.drawCircle(Offset(armX + 14, 22), 6, Paint()..style = PaintingStyle.stroke..strokeWidth = 2..color = const Color(0xFF1a1a1a));

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CourtIsoPainter oldDelegate) => true;
}

class _CourtTopPainter extends CustomPainter {
  final SquashTheme d;
  final BallState? ball;
  final double playerX, oppX;
  final bool showLines, showAvatars;

  _CourtTopPainter({required this.d, this.ball, this.playerX = 0.5, this.oppX = 0.5, this.showLines = true, this.showAvatars = true});

  @override
  void paint(Canvas canvas, Size size) {
    final pad = 18.0;
    final W = size.width, H = size.height;

    canvas.drawRect(Rect.fromLTWH(pad, pad, W - pad * 2, H - pad * 2), Paint()..color = d.courtFloor);
    canvas.drawRect(Rect.fromLTWH(pad, pad, W - pad * 2, 6), Paint()..color = d.courtTin);

    if (showLines) {
      final lp = Paint()..color = d.courtLine..strokeWidth = 1.5..style = PaintingStyle.stroke;
      final cy1 = pad + (H - pad * 2) * 0.45;
      final cy2 = pad + (H - pad * 2) * 0.65;
      canvas.drawLine(Offset(pad, cy1), Offset(W - pad, cy1), Paint()..color = d.courtLine..strokeWidth = 2);
      canvas.drawLine(Offset(pad, cy2), Offset(W - pad, cy2), lp);
      canvas.drawLine(Offset(W / 2, cy2), Offset(W / 2, H - pad), Paint()..color = d.courtLine..strokeWidth = 2);
    }

    if (showAvatars) {
      final cx = (x) => pad + x * (W - pad * 2);
      final cy = (z) => H - pad - z * (H - pad * 2);
      canvas.drawCircle(Offset(cx(playerX), cy(0.1)), 9, Paint()..color = d.primary);
      canvas.drawCircle(Offset(cx(oppX), cy(0.85)), 9, Paint()..color = d.bad);
    }

    if (ball != null) {
      final cx = (x) => pad + x * (W - pad * 2);
      final cy = (z) => H - pad - z * (H - pad * 2);
      canvas.drawCircle(Offset(cx(ball!.x), cy(ball!.z)), 5, Paint()..color = const Color(0xFF0B0B0B));
      canvas.drawCircle(Offset(cx(ball!.x), cy(ball!.z)), 5, Paint()..style = PaintingStyle.stroke..strokeWidth = 1.4..color = d.primary);
    }
  }

  @override
  bool shouldRepaint(covariant _CourtTopPainter oldDelegate) => true;
}

class _CourtSidePainter extends CustomPainter {
  final SquashTheme d;
  final BallState? ball;

  _CourtSidePainter({required this.d, this.ball});

  @override
  void paint(Canvas canvas, Size size) {
    final W = size.width, H = size.height;

    canvas.drawRect(Rect.fromLTWH(0, 0, W, H), Paint()..color = d.courtFloor2);
    canvas.drawRect(Rect.fromLTWH(0, 0, 12, H), Paint()..color = d.courtWall);
    canvas.drawRect(Rect.fromLTWH(0, H - 14, W, 14), Paint()..color = d.courtTin);
    canvas.drawLine(Offset(12, H * 0.45), Offset(W, H * 0.45), Paint()..color = d.courtLine..strokeWidth = 2);

    canvas.drawRect(Rect.fromLTWH(20, H * 0.4, 6, 50), Paint()..color = Colors.white);
    canvas.drawRect(Rect.fromLTWH(W - 26, H * 0.55, 6, 50), Paint()..color = d.primary);

    if (ball != null) {
      canvas.drawCircle(
        Offset(20 + ball!.x * (W - 40), H * 0.5 + math.sin(ball!.z * 6) * 80),
        6,
        Paint()..color = const Color(0xFF0B0B0B),
      );
      canvas.drawCircle(
        Offset(20 + ball!.x * (W - 40), H * 0.5 + math.sin(ball!.z * 6) * 80),
        6,
        Paint()..style = PaintingStyle.stroke..strokeWidth = 1.4..color = d.primary,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CourtSidePainter oldDelegate) => true;
}
