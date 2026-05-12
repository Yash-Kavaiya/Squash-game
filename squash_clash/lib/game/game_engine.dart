import 'dart:math';

class BallState {
  double x, z, y;
  double vx, vz, vy;
  String lastHitBy;

  BallState({
    this.x = 0.5,
    this.z = 0.1,
    this.y = 0.4,
    this.vx = 0,
    this.vz = 0.5,
    this.vy = 0,
    this.lastHitBy = 'p',
  });
}

class PlayerState {
  double x;
  bool swingArmed;
  double cooldown;

  PlayerState({this.x = 0.5, this.swingArmed = false, this.cooldown = 0});
}

class GameState {
  BallState ball;
  PlayerState player;
  PlayerState opponent;
  String serve;
  double since;

  GameState({
    BallState? ball,
    PlayerState? player,
    PlayerState? opponent,
    this.serve = 'p',
    this.since = 0,
  })  : ball = ball ?? BallState(),
        player = player ?? PlayerState(),
        opponent = PlayerState();
}

class AIConfig {
  final double speed;
  final double miss;

  const AIConfig({required this.speed, required this.miss});
}

const aiConfigs = {
  'beginner': AIConfig(speed: 0.6, miss: 0.18),
  'intermediate': AIConfig(speed: 0.95, miss: 0.10),
  'pro': AIConfig(speed: 1.35, miss: 0.04),
};

class GameEngine {
  final GameState state;
  final AIConfig aiConfig;
  final Function(String winner, String kind, String? text)? onPoint;
  final Function(String who)? onHit;
  final Random _rand = Random();

  GameEngine({
    required this.state,
    this.aiConfig = const AIConfig(speed: 1.35, miss: 0.04),
    this.onPoint,
    this.onHit,
  });

  void resetBall(String winner) {
    state.ball = BallState(
      x: winner == 'p' ? 0.3 : 0.7,
      z: 0.05,
      y: 0.4,
      vz: 0.6 + _rand.nextDouble() * 0.2,
      vy: -0.4,
      lastHitBy: winner,
    );
    state.serve = winner;
    state.since = 0;
  }

  void hit(String who, {double? targetX}) {
    final target = targetX ??
        (who == 'p'
            ? 0.2 + _rand.nextDouble() * 0.6
            : state.player.x + (_rand.nextDouble() - 0.5) * 0.3);
    final dx = target - state.ball.x;
    state.ball.vx = dx * 1.4 + (_rand.nextDouble() - 0.5) * 0.2;
    state.ball.vz = who == 'p' ? 1.1 + _rand.nextDouble() * 0.3 : -1.0 - _rand.nextDouble() * 0.3;
    state.ball.vy = 0.55;
    state.ball.y = max(state.ball.y, 0.25);
    state.ball.lastHitBy = who;
    onHit?.call(who);
  }

  void pointScored(String winner, {String? text}) {
    onPoint?.call(winner, winner == 'p' ? 'good' : 'bad', text);
    resetBall(winner);
  }

  void update(double dt) {
    final s = state;
    s.since += dt;

    s.ball.x += s.ball.vx * dt;
    s.ball.z += s.ball.vz * dt;
    s.ball.y += s.ball.vy * dt;
    s.ball.vy -= 0.9 * dt;
    s.ball.vx *= 0.998;
    s.ball.vz *= 0.998;

    if (s.ball.x < 0.02) {
      s.ball.x = 0.02;
      s.ball.vx = s.ball.vx.abs();
    }
    if (s.ball.x > 0.98) {
      s.ball.x = 0.98;
      s.ball.vx = -s.ball.vx.abs();
    }

    if (s.ball.y < 0) {
      s.ball.y = 0;
      s.ball.vy = -s.ball.vy * 0.62;
    }

    if (s.ball.z >= 1) {
      if (s.ball.y < 0.08) {
        pointScored(s.ball.lastHitBy == 'p' ? 'o' : 'p', text: 'TIN!');
        return;
      }
      s.ball.z = 1;
      s.ball.vz = -s.ball.vz.abs();
      s.ball.vy += 0.1;
    }

    if (s.ball.z <= 0) {
      s.ball.z = 0;
      s.ball.vz = s.ball.vz.abs() * 0.7;
    }

    const hitRange = 0.18;
    if (s.player.cooldown <= 0 &&
        s.ball.z < hitRange &&
        s.ball.vz < 0 &&
        (s.ball.x - s.player.x).abs() < 0.18 &&
        s.ball.y < 0.7) {
      if (s.player.swingArmed) {
        hit('p');
        s.player.cooldown = 0.4;
        s.player.swingArmed = false;
      } else if (s.since > 1.5) {
        if (s.ball.z < 0.02) pointScored('o', text: 'MISS!');
      }
    }

    final targetX = s.ball.x + (_rand.nextDouble() - 0.5) * aiConfig.miss;
    s.opponent.x += (targetX - s.opponent.x) * aiConfig.speed * dt * 4;
    s.opponent.x = max(0.08, min(0.92, s.opponent.x));

    if (s.opponent.cooldown <= 0 &&
        s.ball.z > 0.78 &&
        s.ball.vz > 0 &&
        (s.ball.x - s.opponent.x).abs() < 0.22 &&
        s.ball.y < 0.9) {
      if (_rand.nextDouble() > aiConfig.miss * 0.4) {
        hit('o');
        s.opponent.cooldown = 0.35;
      }
    }

    s.player.cooldown = max(0, s.player.cooldown - dt);
    s.opponent.cooldown = max(0, s.opponent.cooldown - dt);

    if (s.ball.z <= 0.0 && s.ball.y < 0.05 && s.ball.lastHitBy == 'o') {
      pointScored('o', text: 'POINT AI!');
    }
  }
}
