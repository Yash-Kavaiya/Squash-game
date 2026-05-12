// game.jsx — Playable isometric squash mini-game.
// Renders inside a phone-sized frame. Drag horizontally on the lower half to
// move the player, swipe up to swing. Ball moves in (x,z) plane with a height y.

function useGameLoop(running, cb) {
  const cbRef = React.useRef(cb);
  cbRef.current = cb;
  React.useEffect(() => {
    if (!running) return;
    let raf = 0, last = performance.now();
    const tick = (t) => {
      const dt = Math.min(0.05, (t - last) / 1000);
      last = t;
      cbRef.current(dt);
      raf = requestAnimationFrame(tick);
    };
    raf = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(raf);
  }, [running]);
}

function PlayableSquash({ d, W = 390, H = 580, difficulty = 'pro', courtView = 'iso', hudLayout = 'classic', live = true }) {
  // Game state stored in refs to avoid re-renders on every frame.
  const stateRef = React.useRef(null);
  const [tick, setTick] = React.useState(0);
  const [score, setScore] = React.useState([0, 0]);
  const [gameNum, setGameNum] = React.useState(1);
  const [feedback, setFeedback] = React.useState(null);
  const [power, setPower] = React.useState(0);
  const [swinging, setSwinging] = React.useState(false);

  if (!stateRef.current) {
    stateRef.current = {
      ball: { x: 0.5, z: 0.1, y: 0.4, vx: 0, vz: 0.5, vy: 0, lastHitBy: 'p' },
      player: { x: 0.5 },
      opp: { x: 0.5 },
      coolP: 0, coolO: 0,
      serve: 'p',
      since: 0,
    };
  }
  const aiCfg = { beginner: { speed: 0.6, react: 0.18, miss: 0.18 }, intermediate: { speed: 0.95, react: 0.10, miss: 0.10 }, pro: { speed: 1.35, react: 0.05, miss: 0.04 } }[difficulty] || { speed: 1, react: 0.1, miss: 0.1 };

  const resetBall = (winner) => {
    const s = stateRef.current;
    s.ball = { x: winner === 'p' ? 0.3 : 0.7, z: 0.05, y: 0.4, vx: 0, vz: 0.6 + Math.random()*0.2, vy: -0.4, lastHitBy: winner };
    s.serve = winner;
    s.since = 0;
  };

  const onHit = (who) => {
    const s = stateRef.current;
    // Send the ball toward the front wall with some lateral component
    const target = who === 'p' ? (0.2 + Math.random() * 0.6) : (s.player.x + (Math.random()-0.5)*0.3);
    const dx = (target - s.ball.x);
    s.ball.vx = dx * 1.4 + (Math.random()-0.5)*0.2;
    s.ball.vz = who === 'p' ? 1.1 + Math.random()*0.3 : -1.0 - Math.random()*0.3;
    s.ball.vy = 0.55;
    s.ball.y = Math.max(s.ball.y, 0.25);
    s.ball.lastHitBy = who;
    if (who === 'p') {
      setFeedback({ kind: 'good', text: ['NICE','DRIVE','SMASH','RAIL'][Math.floor(Math.random()*4)] });
      setTimeout(() => setFeedback(null), 700);
    }
  };

  const point = (winner) => {
    setScore((prev) => {
      const n = [...prev];
      n[winner === 'p' ? 0 : 1]++;
      return n;
    });
    setFeedback({ kind: winner === 'p' ? 'good' : 'bad', text: winner === 'p' ? 'POINT!' : 'TIN!' });
    setTimeout(() => setFeedback(null), 900);
    resetBall(winner);
  };

  useGameLoop(live, (dt) => {
    const s = stateRef.current;
    s.since += dt;
    // Ball physics
    s.ball.x += s.ball.vx * dt;
    s.ball.z += s.ball.vz * dt;
    s.ball.y += s.ball.vy * dt;
    s.ball.vy -= 0.9 * dt; // gravity in normalized units
    // Air drag
    s.ball.vx *= 0.998; s.ball.vz *= 0.998;

    // Side walls
    if (s.ball.x < 0.02) { s.ball.x = 0.02; s.ball.vx = Math.abs(s.ball.vx); }
    if (s.ball.x > 0.98) { s.ball.x = 0.98; s.ball.vx = -Math.abs(s.ball.vx); }

    // Floor bounce
    if (s.ball.y < 0) {
      s.ball.y = 0; s.ball.vy = -s.ball.vy * 0.62;
      // If ball hits floor twice on a side, that side loses
    }

    // Front wall (z = 1)
    if (s.ball.z >= 1) {
      // Check tin (too low when hitting front wall)
      const wallY = s.ball.y;
      if (wallY < 0.08) {
        // Tin — opposite player scores
        point(s.ball.lastHitBy === 'p' ? 'o' : 'p');
        return;
      }
      s.ball.z = 1; s.ball.vz = -Math.abs(s.ball.vz);
      s.ball.vy += 0.1;
    }

    // Back wall (z = 0)
    if (s.ball.z <= 0) {
      s.ball.z = 0; s.ball.vz = Math.abs(s.ball.vz) * 0.7;
    }

    // Player paddle zone — when ball is close to player (z<0.18) and y low and lateral close
    const HIT_RANGE = 0.18;
    if (s.coolP <= 0 && s.ball.z < HIT_RANGE && s.ball.vz < 0 && Math.abs(s.ball.x - s.player.x) < 0.18 && s.ball.y < 0.7) {
      // Auto-hit if swinging requested OR if player is in range (forgiving for prototype)
      if (s.swingArmed) {
        onHit('p'); s.coolP = 0.4; s.swingArmed = false; setSwinging(false); setPower(0);
      } else if (s.since > 1.5 && !s.swingArmed) {
        // If they don't swing in time and ball passes them — point to opp
        if (s.ball.z < 0.02) point('o');
      }
    }

    // Opponent AI — moves toward ball x, hits when in range
    const targetX = s.ball.x + (Math.random()-0.5) * aiCfg.miss;
    s.opp.x += (targetX - s.opp.x) * aiCfg.speed * dt * 4;
    s.opp.x = Math.max(0.08, Math.min(0.92, s.opp.x));
    if (s.coolO <= 0 && s.ball.z > 0.78 && s.ball.vz > 0 && Math.abs(s.ball.x - s.opp.x) < 0.22 && s.ball.y < 0.9) {
      // Opponent occasionally misses
      if (Math.random() > aiCfg.miss * 0.4) {
        onHit('o'); s.coolO = 0.35;
      }
    }
    s.coolP = Math.max(0, s.coolP - dt);
    s.coolO = Math.max(0, s.coolO - dt);

    // Ball goes past player (z < 0) and bounced — opp scores
    if (s.ball.z <= 0.0 && s.ball.y < 0.05 && s.ball.lastHitBy === 'o') {
      point('o');
    }
    if (s.ball.z >= 1.0 && s.ball.y < 0.05 && s.ball.lastHitBy === 'p' && s.ball.vy < 0.05) {
      // shouldn't really happen given wall bounce; safeguard
    }

    setTick((t) => (t + 1) % 1000);
  });

  // Touch / drag input
  const wrapRef = React.useRef(null);
  React.useEffect(() => {
    const el = wrapRef.current;
    if (!el) return;
    let dragging = false; let startY = 0; let startT = 0;
    const onDown = (e) => {
      const t = e.touches ? e.touches[0] : e;
      const rect = el.getBoundingClientRect();
      dragging = true; startY = t.clientY; startT = performance.now();
      // Move player to touch x
      const s = stateRef.current;
      s.player.x = Math.max(0.08, Math.min(0.92, (t.clientX - rect.left) / rect.width));
      setSwinging(true);
    };
    const onMove = (e) => {
      if (!dragging) return;
      const t = e.touches ? e.touches[0] : e;
      const rect = el.getBoundingClientRect();
      const s = stateRef.current;
      s.player.x = Math.max(0.08, Math.min(0.92, (t.clientX - rect.left) / rect.width));
      const dy = Math.max(0, startY - t.clientY);
      setPower(Math.min(1, dy / 140));
    };
    const onUp = (e) => {
      if (!dragging) return;
      dragging = false;
      const s = stateRef.current;
      s.swingArmed = true; // arm a hit on next near-pass
      // If ball is already close, hit it now
      if (s.ball.z < 0.22 && s.ball.vz < 0) { onHit('p'); s.coolP = 0.4; s.swingArmed = false; }
      setTimeout(() => { s.swingArmed = false; setSwinging(false); setPower(0); }, 250);
    };
    el.addEventListener('mousedown', onDown);
    el.addEventListener('touchstart', onDown, { passive: true });
    window.addEventListener('mousemove', onMove);
    window.addEventListener('touchmove', onMove, { passive: true });
    window.addEventListener('mouseup', onUp);
    window.addEventListener('touchend', onUp);
    return () => {
      el.removeEventListener('mousedown', onDown);
      el.removeEventListener('touchstart', onDown);
      window.removeEventListener('mousemove', onMove);
      window.removeEventListener('touchmove', onMove);
      window.removeEventListener('mouseup', onUp);
      window.removeEventListener('touchend', onUp);
    };
  }, []);

  const s = stateRef.current;

  return (
    <div ref={wrapRef} style={{ position: 'relative', width: W, height: H, background: d.bg, overflow: 'hidden', userSelect: 'none', touchAction: 'none' }}>
      {/* Court */}
      <div style={{ position: 'absolute', inset: 0 }}>
        <CourtView d={d} W={W} H={H} ball={s.ball} playerX={s.player.x} oppX={s.opp.x} perspective={courtView} />
      </div>

      {/* HUD overlay */}
      <GameHUD d={d} score={score} gameNum={gameNum} power={power} swinging={swinging} feedback={feedback} layout={hudLayout} />
    </div>
  );
}

function GameHUD({ d, score, gameNum, power, swinging, feedback, layout = 'classic' }) {
  if (layout === 'minimal') return <HUDMinimal d={d} score={score} gameNum={gameNum} power={power} feedback={feedback} />;
  if (layout === 'broadcast') return <HUDBroadcast d={d} score={score} gameNum={gameNum} power={power} feedback={feedback} />;
  return <HUDClassic d={d} score={score} gameNum={gameNum} power={power} feedback={feedback} />;
}

function HUDClassic({ d, score, gameNum, power, feedback }) {
  return (
    <>
      {/* Top score bar */}
      <div style={{ position: 'absolute', top: 14, left: 14, right: 14, display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
        <button style={hudBtn(d)}>‖</button>
        <div style={{ flex: 1, display: 'flex', justifyContent: 'center', gap: 14 }}>
          <ScoreBlock d={d} name="YOU" score={score[0]} accent={d.primary} />
          <div style={{ alignSelf: 'center', color: d.inkDim, fontFamily: d.fontMono, fontSize: 11, letterSpacing: 1 }}>G{gameNum}/5</div>
          <ScoreBlock d={d} name="AI" score={score[1]} accent={d.bad} right />
        </div>
        <button style={hudBtn(d)}>⌕</button>
      </div>

      {/* Power meter bottom */}
      <div style={{ position: 'absolute', left: 14, right: 14, bottom: 18 }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', fontFamily: d.fontMono, fontSize: 10, letterSpacing: 1.5, color: d.inkDim, marginBottom: 6 }}>
          <span>SWING POWER</span>
          <span>{Math.round(power * 100)}%</span>
        </div>
        <div style={{ height: 8, borderRadius: 999, background: 'rgba(255,255,255,0.08)', overflow: 'hidden' }}>
          <div style={{ height: '100%', width: `${power * 100}%`, background: `linear-gradient(90deg, ${d.primary}, ${d.warn})`, transition: 'width 80ms linear' }} />
        </div>
        <div style={{ marginTop: 8, fontSize: 11, color: d.inkDim, textAlign: 'center', fontFamily: d.fontBody }}>Drag to move · Flick up to smash</div>
      </div>

      {feedback && <FeedbackPop d={d} feedback={feedback} />}
    </>
  );
}

function HUDMinimal({ d, score, gameNum, power, feedback }) {
  return (
    <>
      <div style={{ position: 'absolute', top: 14, left: 14, right: 14, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <div style={{ fontFamily: d.fontMono, fontSize: 11, color: d.inkDim, letterSpacing: 1.5 }}>G{gameNum}</div>
        <div style={{ display: 'flex', alignItems: 'baseline', gap: 8, color: d.ink, fontFamily: d.fontMono, fontWeight: 700, fontSize: 40, lineHeight: 1 }}>
          <span style={{ color: d.primary }}>{score[0]}</span>
          <span style={{ color: d.inkMute, fontSize: 22 }}>—</span>
          <span style={{ color: d.bad }}>{score[1]}</span>
        </div>
        <button style={hudBtn(d)}>‖</button>
      </div>
      <div style={{ position: 'absolute', bottom: 18, left: 14, right: 14 }}>
        <div style={{ height: 4, borderRadius: 999, background: 'rgba(255,255,255,0.06)' }}>
          <div style={{ height: '100%', width: `${power * 100}%`, background: d.primary, borderRadius: 999 }} />
        </div>
      </div>
      {feedback && <FeedbackPop d={d} feedback={feedback} />}
    </>
  );
}

function HUDBroadcast({ d, score, gameNum, power, feedback }) {
  return (
    <>
      <div style={{ position: 'absolute', top: 0, left: 0, right: 0, padding: '14px 14px', background: 'linear-gradient(180deg, rgba(0,0,0,0.7), rgba(0,0,0,0))' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
          <div style={{ background: d.bad, color: '#fff', fontFamily: d.fontMono, fontWeight: 700, fontSize: 10, padding: '3px 6px', letterSpacing: 1 }}>● LIVE</div>
          <div style={{ flex: 1 }} />
          <button style={hudBtn(d)}>‖</button>
        </div>
        <div style={{ marginTop: 8, display: 'flex', alignItems: 'stretch', borderRadius: d.rsm, overflow: 'hidden', background: 'rgba(0,0,0,0.55)', border: `1px solid ${d.lineStrong}` }}>
          <div style={{ flex: 1, padding: '10px 12px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderRight: `1px solid ${d.lineStrong}` }}>
            <div>
              <div style={{ fontSize: 11, color: d.inkDim, letterSpacing: 1.4, fontFamily: d.fontMono }}>YOU</div>
              <div style={{ fontFamily: d.fontDisplay, fontSize: 30, lineHeight: 1, color: d.ink, fontWeight: 800 }}>{score[0]}</div>
            </div>
            <div style={{ display: 'flex', flexDirection: 'column', gap: 3 }}>
              {[1,2,3,4,5].map(i => <span key={i} style={{ width: 6, height: 6, borderRadius: 1, background: i <= gameNum ? d.primary : d.lineStrong }} />)}
            </div>
          </div>
          <div style={{ flex: 1, padding: '10px 12px', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <div>
              <div style={{ fontSize: 11, color: d.inkDim, letterSpacing: 1.4, fontFamily: d.fontMono }}>AI · PRO</div>
              <div style={{ fontFamily: d.fontDisplay, fontSize: 30, lineHeight: 1, color: d.ink, fontWeight: 800 }}>{score[1]}</div>
            </div>
          </div>
        </div>
      </div>
      <div style={{ position: 'absolute', bottom: 0, left: 0, right: 0, padding: '10px 14px 16px', background: 'linear-gradient(0deg, rgba(0,0,0,0.7), rgba(0,0,0,0))' }}>
        <div style={{ display: 'flex', gap: 4 }}>
          {Array.from({ length: 16 }).map((_, i) => (
            <div key={i} style={{ flex: 1, height: 12, background: i < Math.round(power * 16) ? (i < 11 ? d.primary : i < 14 ? d.warn : d.bad) : 'rgba(255,255,255,0.06)' }} />
          ))}
        </div>
      </div>
      {feedback && <FeedbackPop d={d} feedback={feedback} />}
    </>
  );
}

function ScoreBlock({ d, name, score, accent, right }) {
  return (
    <div style={{ textAlign: 'center' }}>
      <div style={{ fontFamily: d.fontMono, fontSize: 10, letterSpacing: 1.6, color: d.inkDim }}>{name}</div>
      <div style={{ fontFamily: d.fontDisplay, fontSize: 36, fontWeight: 800, lineHeight: 1, color: accent }}>{score}</div>
    </div>
  );
}

function hudBtn(d) {
  return {
    width: 36, height: 36, borderRadius: 99, background: 'rgba(0,0,0,0.55)', backdropFilter: 'blur(8px)',
    border: `1px solid ${d.lineStrong}`, color: d.ink, fontSize: 16, cursor: 'pointer',
  };
}

function FeedbackPop({ d, feedback }) {
  const color = feedback.kind === 'good' ? d.primary : d.bad;
  return (
    <div style={{ position: 'absolute', top: '38%', left: 0, right: 0, textAlign: 'center', pointerEvents: 'none' }}>
      <div style={{
        display: 'inline-block', padding: '8px 16px', borderRadius: d.rsm,
        background: 'rgba(0,0,0,0.55)', border: `2px solid ${color}`,
        color, fontFamily: d.fontDisplay, fontWeight: 800, fontSize: 28, letterSpacing: 2,
        animation: 'fbpop 700ms ease-out',
      }}>{feedback.text}</div>
      <style>{`@keyframes fbpop { 0% { transform: scale(0.7); opacity: 0; } 30% { transform: scale(1.05); opacity: 1;} 100% { transform: scale(1); opacity: 0.95; } }`}</style>
    </div>
  );
}

Object.assign(window, { PlayableSquash, GameHUD, HUDClassic, HUDMinimal, HUDBroadcast });
