import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/court_view.dart';
import '../widgets/game_hud.dart';
import '../game/game_engine.dart';

class GameScreen extends StatefulWidget {
  final SquashTheme d;
  final VoidCallback onExit;

  const GameScreen({super.key, required this.d, required this.onExit});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameState _state;
  late GameEngine _engine;
  List<int> _score = [0, 0];
  int _gameNum = 1;
  double _power = 0;
  bool _swinging = false;
  String? _feedbackText;
  String? _feedbackKind;
  bool _paused = false;
  String _courtView = 'iso';
  String _hudLayout = 'classic';
  Timer? _gameTimer;
  Timer? _feedbackTimer;

  @override
  void initState() {
    super.initState();
    _state = GameState();
    _engine = GameEngine(
      state: _state,
      onPoint: _onPoint,
      onHit: _onHit,
    );
    _startLoop();
  }

  void _startLoop() {
    _gameTimer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (!_paused) {
        _engine.update(0.016);
        setState(() {});
      }
    });
  }

  void _onPoint(String winner, String kind, String? text) {
    setState(() {
      if (winner == 'p') {
        _score[0]++;
      } else {
        _score[1]++;
      }
      _feedbackKind = kind;
      _feedbackText = text ?? (winner == 'p' ? 'POINT!' : 'TIN!');
    });
    _feedbackTimer?.cancel();
    _feedbackTimer = Timer(const Duration(milliseconds: 900), () {
      if (mounted) setState(() { _feedbackText = null; });
    });
  }

  void _onHit(String who) {
    if (who == 'p') {
      final texts = ['NICE', 'DRIVE', 'SMASH', 'RAIL'];
      setState(() {
        _feedbackKind = 'good';
        _feedbackText = texts[Random().nextInt(texts.length)];
      });
      _feedbackTimer?.cancel();
      _feedbackTimer = Timer(const Duration(milliseconds: 700), () {
        if (mounted) setState(() { _feedbackText = null; });
      });
    }
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    _feedbackTimer?.cancel();
    super.dispose();
  }

  void _togglePause() {
    setState(() => _paused = !_paused);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.d.bg,
      body: SafeArea(
        child: GestureDetector(
          onPanStart: (details) {
            _state.player.x = (details.localPosition.dx / MediaQuery.of(context).size.width).clamp(0.08, 0.92);
          },
          onPanUpdate: (details) {
            _state.player.x = (details.localPosition.dx / MediaQuery.of(context).size.width).clamp(0.08, 0.92);
            final power = (details.delta.dy < 0) ? (details.delta.dy.abs() / 140).clamp(0.0, 1.0) : _power;
            setState(() => _power = power);
          },
          onPanEnd: (_) {
            _state.player.swingArmed = true;
            if (_state.ball.z < 0.22 && _state.ball.vz < 0) {
              _engine.hit('p');
              _state.player.cooldown = 0.4;
              _state.player.swingArmed = false;
            }
            Future.delayed(const Duration(milliseconds: 250), () {
              if (mounted) {
                _state.player.swingArmed = false;
                setState(() { _power = 0; });
              }
            });
          },
          child: Stack(
            children: [
              // Court
              Positioned.fill(
                child: CourtView(
                  d: widget.d,
                  W: MediaQuery.of(context).size.width,
                  H: MediaQuery.of(context).size.height,
                  ball: BallState(x: _state.ball.x, z: _state.ball.z, y: _state.ball.y),
                  playerX: _state.player.x,
                  oppX: _state.opponent.x,
                  perspective: _courtView,
                ),
              ),

              // HUD
              GameHUD(
                d: widget.d,
                score: _score,
                gameNum: _gameNum,
                power: _power,
                swinging: _swinging,
                feedbackText: _feedbackText,
                feedbackKind: _feedbackKind,
                layout: _hudLayout,
              ),

              // Top controls
              Positioned(
                top: 60,
                left: 14,
                child: GestureDetector(
                  onTap: widget.onExit,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      color: Colors.black54,
                      border: Border.all(color: widget.d.lineStrong),
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
                  ),
                ),
              ),

              // Controls info
              Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black54,
                      ),
                      child: Text('Drag to move, release to swing',
                          style: TextStyle(fontSize: 11, color: widget.d.inkDim)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
