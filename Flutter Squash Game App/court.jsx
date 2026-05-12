// court.jsx — Isometric 3/4 view squash court (SVG)
// Renders the court geometry shared by the playable game and the static screens.
// The court is drawn as a trapezoid: front wall at the top, back at the bottom
// (player viewpoint is behind themselves looking forward into the court).

// Normalized court coords (logical):
//   x ∈ [0..1] left → right
//   z ∈ [0..1] back (player) → front (front wall)
// Project to screen coords inside a [0..W]×[0..H] box.

function projectCourt(W, H, x, z, opts = {}) {
  const pad = opts.pad ?? 0.08;
  // Front wall width is narrower than back (perspective)
  const backW  = W * (1 - pad * 0.4);
  const frontW = W * (1 - pad * 1.6);
  const topY   = H * 0.10;
  const botY   = H * (1 - pad);
  // z=1 = at front wall (top of screen), z=0 = at player (bottom)
  const t = z;
  const rowW = backW * (1 - t) + frontW * t;
  const cx   = W / 2;
  const sx   = cx + (x - 0.5) * rowW;
  const sy   = botY * (1 - t) + topY * t;
  return [sx, sy];
}

function CourtView({ d, W = 360, H = 420, ball = null, playerX = 0.5, oppX = 0.5, showLines = true, showAvatars = true, perspective = 'iso' }) {
  // perspective: 'iso' (default), 'top' (top-down), 'side' (Pong-like)
  if (perspective === 'top') return <CourtTop d={d} W={W} H={H} ball={ball} playerX={playerX} oppX={oppX} showLines={showLines} showAvatars={showAvatars} />;
  if (perspective === 'side') return <CourtSide d={d} W={W} H={H} ball={ball} playerX={playerX} oppX={oppX} />;

  // Build perimeter
  const [bx0, by0] = projectCourt(W, H, 0, 0);
  const [bx1, by1] = projectCourt(W, H, 1, 0);
  const [fx0, fy0] = projectCourt(W, H, 0, 1);
  const [fx1, fy1] = projectCourt(W, H, 1, 1);

  // Service box outlines (back third)
  const [sb_z] = [0.35];
  const [sbx0, sby0] = projectCourt(W, H, 0, sb_z);
  const [sbx1, sby1] = projectCourt(W, H, 1, sb_z);
  // Half-court line
  const [hcxA, hcyA] = projectCourt(W, H, 0.5, 0);
  const [hcxB, hcyB] = projectCourt(W, H, 0.5, sb_z);

  // Front-wall vertical face (rises above the floor plane)
  const fwallH = H * 0.36;
  const tinH = fwallH * 0.18;

  // Ball — scale with depth + drop-shadow
  let ballEl = null;
  if (ball) {
    const [sx, sy] = projectCourt(W, H, ball.x, ball.z);
    const r = 7 + (1 - ball.z) * 4;
    const lift = Math.max(0, ball.y || 0) * 30;
    ballEl = (
      <g>
        <ellipse cx={sx} cy={sy + 2} rx={r * 0.9} ry={r * 0.35} fill="rgba(0,0,0,0.45)" />
        <circle cx={sx} cy={sy - lift} r={r} fill="#0B0B0B" stroke={d.primary} strokeWidth="1.5" />
        <circle cx={sx - r*0.35} cy={sy - lift - r*0.35} r={r*0.25} fill="rgba(255,255,255,0.18)" />
      </g>
    );
  }

  // Player + opponent silhouettes (simple stylized figures)
  const [px, py] = projectCourt(W, H, playerX, 0.05);
  const [ox, oy] = projectCourt(W, H, oppX, 0.55);

  return (
    <svg width={W} height={H} viewBox={`0 0 ${W} ${H}`} style={{ display: 'block' }}>
      <defs>
        <linearGradient id={`floor-${d.id}`} x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor={d.courtFloor2} />
          <stop offset="1" stopColor={d.courtFloor} />
        </linearGradient>
        <linearGradient id={`wall-${d.id}`} x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor={d.courtWall} stopOpacity="1" />
          <stop offset="1" stopColor={d.courtWall} stopOpacity="0.85" />
        </linearGradient>
        <linearGradient id={`sideL-${d.id}`} x1="1" y1="0" x2="0" y2="0">
          <stop offset="0" stopColor={d.courtWall} stopOpacity="0.95" />
          <stop offset="1" stopColor={d.courtWall} stopOpacity="0.55" />
        </linearGradient>
        <linearGradient id={`sideR-${d.id}`} x1="0" y1="0" x2="1" y2="0">
          <stop offset="0" stopColor={d.courtWall} stopOpacity="0.95" />
          <stop offset="1" stopColor={d.courtWall} stopOpacity="0.55" />
        </linearGradient>
      </defs>

      {/* Floor (trapezoid) */}
      <polygon points={`${bx0},${by0} ${bx1},${by1} ${fx1},${fy1} ${fx0},${fy0}`} fill={`url(#floor-${d.id})`} />

      {/* Left + right walls (rising up from floor edges to front wall top) */}
      <polygon points={`${bx0},${by0} ${fx0},${fy0} ${fx0},${fy0 - fwallH} ${bx0},${by0 - fwallH*1.1}`} fill={`url(#sideL-${d.id})`} />
      <polygon points={`${bx1},${by1} ${fx1},${fy1} ${fx1},${fy1 - fwallH} ${bx1},${by1 - fwallH*1.1}`} fill={`url(#sideR-${d.id})`} />

      {/* Front wall */}
      <rect x={fx0} y={fy0 - fwallH} width={fx1 - fx0} height={fwallH} fill={`url(#wall-${d.id})`} />
      {/* Tin (red strip near floor of front wall) */}
      <rect x={fx0} y={fy0 - tinH} width={fx1 - fx0} height={tinH} fill={d.courtTin} />
      <rect x={fx0} y={fy0 - tinH - 2} width={fx1 - fx0} height={2} fill={d.courtLine} />

      {showLines && (
        <g stroke={d.courtLine} strokeWidth="1.5" fill="none">
          {/* Service line on front wall */}
          <line x1={fx0} y1={fy0 - fwallH * 0.45} x2={fx1} y2={fy0 - fwallH * 0.45} strokeWidth="2" />
          {/* Out line on front wall */}
          <line x1={fx0} y1={fy0 - fwallH * 0.95} x2={fx1} y2={fy0 - fwallH * 0.95} />
          {/* Service boxes (floor) */}
          <line x1={sbx0} y1={sby0} x2={sbx1} y2={sby1} strokeWidth="2" />
          <line x1={hcxA} y1={hcyA} x2={hcxB} y2={hcyB} strokeWidth="2" />
          {/* Side wall out lines (slanting up) */}
          <line x1={bx0} y1={by0 - fwallH*1.1} x2={fx0} y2={fy0 - fwallH} />
          <line x1={bx1} y1={by1 - fwallH*1.1} x2={fx1} y2={fy1 - fwallH} />
        </g>
      )}

      {showAvatars && (
        <g>
          <Avatar x={ox} y={oy} dir="back" tint={d.bad} scale={0.85} />
          <Avatar x={px} y={py} dir="front" tint={d.primary} scale={1} />
        </g>
      )}

      {ballEl}
    </svg>
  );
}

function Avatar({ x, y, dir, tint = '#fff', scale = 1 }) {
  const s = scale;
  return (
    <g transform={`translate(${x - 16*s}, ${y - 70*s}) scale(${s})`}>
      <ellipse cx="16" cy="68" rx="14" ry="3.5" fill="rgba(0,0,0,0.35)" />
      {/* body */}
      <path d="M16 18 c -6 0 -10 5 -10 12 v 18 c 0 4 2 6 4 6 h 12 c 2 0 4 -2 4 -6 v -18 c 0 -7 -4 -12 -10 -12 z" fill="#1a1a1a" />
      {/* shorts */}
      <path d="M6 48 v 16 h 8 v -16 z M18 48 v 16 h 8 v -16 z" fill={tint} opacity="0.9" />
      {/* head */}
      <circle cx="16" cy="10" r="7" fill="#3a2e23" />
      {/* racket arm */}
      <rect x={dir==='front' ? 22 : -4} y="24" width="10" height="3.5" fill="#1a1a1a" rx="1.5" />
      <circle cx={dir==='front' ? 36 : -10} cy="22" r="6" fill="none" stroke="#1a1a1a" strokeWidth="2" />
    </g>
  );
}

function CourtTop({ d, W, H, ball, playerX, oppX, showLines, showAvatars }) {
  const pad = 18;
  const cx = (x) => pad + x * (W - pad * 2);
  const cy = (z) => H - pad - z * (H - pad * 2);
  return (
    <svg width={W} height={H} viewBox={`0 0 ${W} ${H}`}>
      <rect x={pad} y={pad} width={W - pad*2} height={H - pad*2} fill={d.courtFloor} />
      {/* tin (front) */}
      <rect x={pad} y={pad} width={W - pad*2} height={6} fill={d.courtTin} />
      {showLines && (
        <g stroke={d.courtLine} strokeWidth="1.5" fill="none">
          <line x1={pad} y1={pad + (H-pad*2)*0.45} x2={W-pad} y2={pad + (H-pad*2)*0.45} strokeWidth="2" />
          <line x1={pad} y1={pad + (H-pad*2)*0.65} x2={W-pad} y2={pad + (H-pad*2)*0.65} strokeWidth="2" />
          <line x1={W/2} y1={pad + (H-pad*2)*0.65} x2={W/2} y2={H-pad} strokeWidth="2" />
        </g>
      )}
      {showAvatars && (<>
        <circle cx={cx(playerX)} cy={cy(0.1)} r="9" fill={d.primary} stroke="#000" />
        <circle cx={cx(oppX)} cy={cy(0.85)} r="9" fill={d.bad} stroke="#000" />
      </>)}
      {ball && (<>
        <ellipse cx={cx(ball.x)+1} cy={cy(ball.z)+1} rx="6" ry="6" fill="rgba(0,0,0,0.4)" />
        <circle cx={cx(ball.x)} cy={cy(ball.z)} r="5" fill="#0B0B0B" stroke={d.primary} strokeWidth="1.4" />
      </>)}
    </svg>
  );
}

function CourtSide({ d, W, H, ball }) {
  // Pong-like horizontal court
  return (
    <svg width={W} height={H} viewBox={`0 0 ${W} ${H}`}>
      <rect x="0" y="0" width={W} height={H} fill={d.courtFloor2} />
      <rect x="0" y="0" width="12" height={H} fill={d.courtWall} />
      <rect x="0" y={H-14} width={W} height={14} fill={d.courtTin} />
      <line x1="12" y1={H*0.45} x2={W} y2={H*0.45} stroke={d.courtLine} strokeWidth="2" />
      <rect x="20" y={H*0.4} width="6" height="50" fill="#fff" />
      <rect x={W-26} y={H*0.55} width="6" height="50" fill={d.primary} />
      {ball && (
        <circle cx={20 + (ball.x) * (W - 40)} cy={H*0.5 + Math.sin(ball.z * 6) * 80} r="6" fill="#0B0B0B" stroke={d.primary} strokeWidth="1.4" />
      )}
    </svg>
  );
}

Object.assign(window, { CourtView, projectCourt });
