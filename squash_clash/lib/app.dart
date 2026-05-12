import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/game_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/achievements_screen.dart';

class SquashClashApp extends StatefulWidget {
  const SquashClashApp({super.key});

  @override
  State<SquashClashApp> createState() => _SquashClashAppState();
}

class _SquashClashAppState extends State<SquashClashApp> {
  SquashTheme _theme = squashThemePace;
  int _navIndex = 0;

  void _setTheme(SquashTheme theme) {
    setState(() => _theme = theme);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squash Clash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: _theme.bg,
        colorScheme: ColorScheme.dark(
          primary: _theme.primary,
          surface: _theme.bg,
        ),
      ),
      home: Scaffold(
        backgroundColor: _theme.bg,
        body: _buildScreen(),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  Widget _buildScreen() {
    switch (_navIndex) {
      case 0:
        return HomeScreen(
          d: _theme,
          onStartGame: () => setState(() => _navIndex = 1),
          onThemeChanged: _setTheme,
        );
      case 1:
        return GameScreen(
          d: _theme,
          onExit: () => setState(() => _navIndex = 0),
        );
      case 2:
        return StatsScreen(d: _theme);
      case 3:
        return const SizedBox();
      default:
        return HomeScreen(d: _theme, onStartGame: () {}, onThemeChanged: _setTheme);
    }
  }

  Widget _buildBottomNav() {
    final items = [
      ('Home', Icons.home),
      ('Play', Icons.play_arrow),
      ('Stats', Icons.bar_chart),
      ('Me', Icons.person),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(99),
        color: _theme.id == 'court'
            ? Colors.white.withOpacity(0.92)
            : Colors.white.withOpacity(0.06),
        border: Border.all(color: _theme.line),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final active = i == _navIndex;
          return GestureDetector(
            onTap: () => setState(() => _navIndex = i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                color: active ? _theme.primary : Colors.transparent,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(items[i].$2,
                      size: 16,
                      color: active ? _theme.primaryInk : _theme.inkDim),
                  if (active)
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(items[i].$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _theme.primaryInk)),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
