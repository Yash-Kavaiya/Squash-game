import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  final SquashTheme d;
  const SettingsScreen({super.key, required this.d});

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
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      color: d.chip,
                      border: Border.all(color: d.line),
                    ),
                    child: const Icon(Icons.arrow_back, size: 18),
                  ),
                ),
                const SizedBox(width: 12),
                Text('Settings',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: d.ink)),
              ],
            ),

            _settingsGroup('GAMEPLAY', [
              _settingRow('Difficulty', value: 'Pro'),
              _settingRow('Game speed', value: 'Standard'),
              _settingRow('Best of', value: '5 games'),
              _settingRow('Auto-let detection', toggle: true),
            ]),
            _settingsGroup('CONTROLS', [
              _settingRow('Swing sensitivity', slider: 70),
              _settingRow('Joystick size', value: 'Medium'),
              _settingRow('Tilt steering', toggle: true, off: true),
              _settingRow('Haptics', toggle: true),
            ]),
            _settingsGroup('DISPLAY', [
              _settingRow('Theme', value: 'Dark · Pace'),
              _settingRow('Court view', value: 'Isometric'),
              _settingRow('High contrast', toggle: true, off: true),
            ]),
            _settingsGroup('AUDIO', [
              _settingRow('Sound effects', slider: 85),
              _settingRow('Crowd ambience', slider: 40),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _settingsGroup(String title, List<Widget> rows) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
            child: Text(title,
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    letterSpacing: 1.5,
                    color: d.inkDim)),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(d.r),
              color: d.card,
              border: Border.all(color: d.line),
            ),
            child: Column(children: rows),
          ),
        ],
      ),
    );
  }

  Widget _settingRow(String label,
      {String? value, bool? toggle, bool? off, int? slider}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: d.line))),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                style: TextStyle(fontSize: 14, color: d.ink)),
          ),
          if (value != null)
            Row(
              children: [
                Text(value,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: d.inkDim)),
                const SizedBox(width: 6),
                Icon(Icons.chevron_right, size: 14, color: d.inkDim),
              ],
            ),
          if (toggle == true)
            Container(
              width: 40,
              height: 22,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                color: off == true ? d.chip : d.primary,
                border: off == true ? Border.all(color: d.line) : null,
              ),
              child: Container(
                alignment: off == true ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    color: off == true ? d.inkMute : d.primaryInk,
                  ),
                ),
              ),
            ),
          if (slider != null)
            SizedBox(
              width: 120,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(99),
                        color: d.chip,
                      ),
                      child: Stack(
                        children: [
                          FractionallySizedBox(
                            widthFactor: slider / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(99),
                                color: d.primary,
                              ),
                            ),
                          ),
                          Positioned(
                            left: '${slider}%' as double? ?? 0,
                            top: -5,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(99),
                                color: d.ink,
                                border: Border.all(color: d.primary, width: 2),
                              ),
                            ),
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
}
