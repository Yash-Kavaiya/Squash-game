import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BrandMark extends StatelessWidget {
  final SquashTheme d;
  const BrandMark({super.key, required this.d});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: d.primary,
            borderRadius: BorderRadius.circular(d.id == 'stadium' ? 0 : 8),
          ),
          child: Center(
            child: Text('S',
                style: TextStyle(
                    color: d.primaryInk,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w900,
                    fontSize: 16)),
          ),
        ),
        const SizedBox(width: 8),
        Text('SQUASH CLASH',
            style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: d.ink)),
      ],
    );
  }
}

class PillBtn extends StatelessWidget {
  final SquashTheme d;
  final Widget child;
  final bool compact;
  final VoidCallback? onTap;
  const PillBtn(
      {super.key,
      required this.d,
      required this.child,
      this.compact = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: compact ? 10 : 16, vertical: compact ? 6 : 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(99),
          border: Border.all(color: d.line),
          color: d.chip,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
              color: d.ink,
              fontFamily: 'Inter',
              fontSize: compact ? 11 : 13,
              fontWeight: FontWeight.w600),
          child: child,
        ),
      ),
    );
  }
}

class ModeCard extends StatelessWidget {
  final SquashTheme d;
  final IconData icon;
  final String title;
  final String sub;
  final VoidCallback? onTap;

  const ModeCard(
      {super.key,
      required this.d,
      required this.icon,
      required this.title,
      required this.sub,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(d.r),
          border: Border.all(color: d.line),
          color: d.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: d.primary, size: 20),
            const SizedBox(height: 8),
            Text(title,
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: d.ink)),
            const SizedBox(height: 2),
            Text(sub,
                style: TextStyle(fontSize: 11, color: d.inkDim)),
          ],
        ),
      ),
    );
  }
}

class RowBtn extends StatelessWidget {
  final SquashTheme d;
  final IconData icon;
  final String label;
  final bool muted;
  final VoidCallback? onTap;
  const RowBtn(
      {super.key,
      required this.d,
      required this.icon,
      required this.label,
      this.muted = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(d.r),
          color: const Color(0x0FFFFFFF),
          border: Border.all(color: d.line),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: muted ? d.bad : Colors.white),
            const SizedBox(width: 12),
            Text(label,
                style: TextStyle(
                    color: muted ? d.bad : Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
            const Spacer(),
            Icon(Icons.chevron_right, size: 16, color: Colors.white54),
          ],
        ),
      ),
    );
  }
}

class HUDButton extends StatelessWidget {
  final SquashTheme d;
  final String label;
  final VoidCallback? onTap;
  const HUDButton({super.key, required this.d, this.label = '', this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
