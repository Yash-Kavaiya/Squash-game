// screens.jsx — Static screen mocks for Squash Clash.
// Each screen is a plain component that fills its parent (the phone frame).
// They take a direction token object `d` so the visual style swaps in place.

const Icon = {
  Play: (p) => <svg viewBox="0 0 24 24" width={p.s||20} height={p.s||20} fill="currentColor"><path d="M7 4v16l13-8z"/></svg>,
  Pause: (p) => <svg viewBox="0 0 24 24" width={p.s||20} height={p.s||20} fill="currentColor"><rect x="6" y="4" width="4" height="16"/><rect x="14" y="4" width="4" height="16"/></svg>,
  Bolt: (p) => <svg viewBox="0 0 24 24" width={p.s||20} height={p.s||20} fill="currentColor"><path d="M13 2L4 14h6l-1 8 9-12h-6l1-8z"/></svg>,
  Trophy: (p) => <svg viewBox="0 0 24 24" width={p.s||20} height={p.s||20} fill="none" stroke="currentColor" strokeWidth="2"><path d="M7 4h10v4a5 5 0 0 1-10 0V4z"/><path d="M5 6H3a3 3 0 0 0 4 3M19 6h2a3 3 0 0 1-4 3"/><path d="M9 20h6M12 14v6"/></svg>,
  Stats: (p) => <svg viewBox="0 0 24 24" width={p.s||20} height={p.s||20} fill="none" stroke="currentColor" strokeWidth="2"><path d="M4 20V10M10 20V4M16 20v-7M22 20H2"/></svg>,
  Cog: (p) => <svg viewBox="0 0 24 24" width={p.s||20} height={p.s||20} fill="none" stroke="currentColor" strokeWidth="2"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.7 1.7 0 0 0 .3 1.8l.1.1a2 2 0 1 1-2.8 2.8l-.1-.1a1.7 1.7 0 0 0-1.8-.3 1.7 1.7 0 0 0-1 1.5V21a2 2 0 1 1-4 0v-.1a1.7 1.7 0 0 0-1.1-1.5 1.7 1.7 0 0 0-1.8.3l-.1.1A2 2 0 1 1 4.3 17l.1-.1a1.7 1.7 0 0 0 .3-1.8 1.7 1.7 0 0 0-1.5-1H3a2 2 0 1 1 0-4h.1a1.7 1.7 0 0 0 1.5-1.1 1.7 1.7 0 0 0-.3-1.8l-.1-.1A2 2 0 1 1 7 4.3l.1.1a1.7 1.7 0 0 0 1.8.3H9a1.7 1.7 0 0 0 1-1.5V3a2 2 0 1 1 4 0v.1a1.7 1.7 0 0 0 1 1.5 1.7 1.7 0 0 0 1.8-.3l.1-.1a2 2 0 1 1 2.8 2.8l-.1.1a1.7 1.7 0 0 0-.3 1.8V9a1.7 1.7 0 0 0 1.5 1H21a2 2 0 1 1 0 4h-.1a1.7 1.7 0 0 0-1.5 1z"/></svg>,
  Users: (p) => <svg viewBox="0 0 24 24" width={p.s||20} height={p.s||20} fill="none" stroke="currentColor" strokeWidth="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87M16 3.13A4 4 0 0 1 16 11"/></svg>,
  Target: (p) => <svg viewBox="0 0 24 24" width={p.s||20} height={p.s||20} fill="none" stroke="currentColor" strokeWidth="2"><circle cx="12" cy="12" r="10"/><circle cx="12" cy="12" r="6"/><circle cx="12" cy="12" r="2"/></svg>,
  Home: (p) => <svg viewBox="0 0 24 24" width={p.s||20} height={p.s||20} fill="none" stroke="currentColor" strokeWidth="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2h-4v-7H10v7H5a2 2 0 0 1-2-2z"/></svg>,
  X: (p) => <svg viewBox="0 0 24 24" width={p.s||20} height={p.s||20} fill="none" stroke="currentColor" strokeWidth="2"><path d="M18 6L6 18M6 6l12 12"/></svg>,
  Chevron: (p) => <svg viewBox="0 0 24 24" width={p.s||20} height={p.s||20} fill="none" stroke="currentColor" strokeWidth="2"><path d="M9 6l6 6-6 6"/></svg>,
  Share: (p) => <svg viewBox="0 0 24 24" width={p.s||20} height={p.s||20} fill="none" stroke="currentColor" strokeWidth="2"><path d="M4 12v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-8M16 6l-4-4-4 4M12 2v13"/></svg>,
  Replay: (p) => <svg viewBox="0 0 24 24" width={p.s||20} height={p.s||20} fill="none" stroke="currentColor" strokeWidth="2"><path d="M1 4v6h6M23 20v-6h-6M3.5 9A9 9 0 0 1 21 12M20.5 15A9 9 0 0 1 3 12"/></svg>,
};

// ── Home / Main menu ─────────────────────────────────────────
function ScreenHome({ d, W, H, topPad = 0, botPad = 0 }) {
  const isLight = d.id === 'court';
  return (
    <div style={{ width: W, height: H, background: d.bg, color: d.ink, fontFamily: d.fontBody, paddingTop: topPad, paddingBottom: botPad, position: 'relative', overflow: 'hidden' }}>
      {/* Hero court visual */}
      <div style={{ position: 'absolute', top: topPad, left: 0, right: 0, height: H * 0.44, opacity: 0.95 }}>
        <CourtView d={d} W={W} H={H * 0.44} ball={{ x: 0.55, z: 0.45, y: 0.3 }} playerX={0.4} oppX={0.6} />
        <div style={{ position: 'absolute', inset: 0, background: `linear-gradient(180deg, transparent 50%, ${d.bg} 98%)` }} />
      </div>

      {/* Brand */}
      <div style={{ position: 'relative', padding: '14px 20px 0', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <BrandMark d={d} />
        <div style={{ display: 'flex', gap: 8 }}>
          <PillBtn d={d} compact>L4</PillBtn>
          <PillBtn d={d} compact><Icon.Cog s={14} /></PillBtn>
        </div>
      </div>

      {/* Player card */}
      <div style={{ position: 'absolute', top: H * 0.36, left: 20, right: 20, padding: '14px 16px', borderRadius: d.r, background: isLight ? 'rgba(255,255,255,0.92)' : 'rgba(20,26,28,0.85)', backdropFilter: 'blur(12px)', border: `1px solid ${d.lineStrong}`, display: 'flex', alignItems: 'center', gap: 12 }}>
        <div style={{ width: 44, height: 44, borderRadius: 99, background: `linear-gradient(135deg, ${d.primary}, ${d.warn})`, display: 'grid', placeItems: 'center', fontFamily: d.fontDisplay, fontWeight: 800, color: d.primaryInk, fontSize: 18 }}>MK</div>
        <div style={{ flex: 1 }}>
          <div style={{ fontSize: 11, color: d.inkDim, fontFamily: d.fontMono, letterSpacing: 1.4 }}>WELCOME BACK</div>
          <div style={{ fontFamily: d.fontDisplay, fontSize: 18, fontWeight: 700, lineHeight: 1.1, marginTop: 2 }}>Mira K.</div>
        </div>
        <div style={{ textAlign: 'right' }}>
          <div style={{ fontFamily: d.fontMono, fontSize: 11, color: d.inkDim, letterSpacing: 1 }}>STREAK</div>
          <div style={{ fontFamily: d.fontDisplay, fontSize: 22, fontWeight: 800, color: d.primary }}>7</div>
        </div>
      </div>

      {/* Main CTA */}
      <div style={{ position: 'absolute', top: H * 0.52, left: 20, right: 20 }}>
        <button style={{
          width: '100%', padding: '18px 20px', borderRadius: d.r,
          background: d.primary, color: d.primaryInk, border: 'none',
          fontFamily: d.fontDisplay, fontSize: 20, fontWeight: 800, letterSpacing: 1,
          display: 'flex', alignItems: 'center', justifyContent: 'space-between', cursor: 'pointer',
        }}>
          <span style={{ display: 'flex', alignItems: 'center', gap: 10 }}><Icon.Play s={22} /> QUICK MATCH</span>
          <span style={{ fontFamily: d.fontMono, fontSize: 12, opacity: 0.75 }}>VS PRO AI</span>
        </button>
      </div>

      {/* Grid of modes */}
      <div style={{ position: 'absolute', top: H * 0.64, left: 20, right: 20, display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10 }}>
        <ModeCard d={d} icon={<Icon.Target />} title="Practice" sub="Drills · Solo" />
        <ModeCard d={d} icon={<Icon.Users />} title="2-Player" sub="Local hot-seat" />
        <ModeCard d={d} icon={<Icon.Stats />} title="Stats" sub="Win 68% · 23 W" />
        <ModeCard d={d} icon={<Icon.Trophy />} title="Achievements" sub="14 / 40" />
      </div>

      {/* Bottom nav */}
      <div style={{ position: 'absolute', bottom: botPad + 8, left: 20, right: 20, padding: 6, borderRadius: 99, background: isLight ? 'rgba(255,255,255,0.92)' : 'rgba(255,255,255,0.06)', backdropFilter: 'blur(10px)', border: `1px solid ${d.line}`, display: 'flex', justifyContent: 'space-around' }}>
        {[['Home', Icon.Home, true], ['Play', Icon.Play, false], ['History', Icon.Stats, false], ['Me', Icon.Users, false]].map(([t, Ic, active], i) => (
          <button key={i} style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 2, padding: '6px 10px', background: active ? d.primary : 'transparent', borderRadius: 99, border: 'none', color: active ? d.primaryInk : d.inkDim, fontFamily: d.fontBody, fontSize: 10, cursor: 'pointer' }}>
            <Ic s={16} />
            <span style={{ fontWeight: 600, letterSpacing: 0.4 }}>{t}</span>
          </button>
        ))}
      </div>
    </div>
  );
}

function BrandMark({ d }) {
  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
      <div style={{ width: 28, height: 28, borderRadius: d.id === 'stadium' ? 0 : 8, background: d.primary, display: 'grid', placeItems: 'center', color: d.primaryInk, fontFamily: d.fontDisplay, fontWeight: 900, fontSize: 16 }}>S</div>
      <div style={{ fontFamily: d.fontDisplay, fontWeight: 800, fontSize: 16, letterSpacing: d.id === 'stadium' ? 2 : 0.5 }}>SQUASH CLASH</div>
    </div>
  );
}

function PillBtn({ d, children, compact, onClick }) {
  return (
    <button onClick={onClick} style={{
      padding: compact ? '6px 10px' : '10px 16px',
      borderRadius: 99, border: `1px solid ${d.line}`, background: d.chip,
      color: d.ink, fontFamily: d.fontBody, fontSize: compact ? 11 : 13, fontWeight: 600, cursor: 'pointer',
      display: 'flex', alignItems: 'center', gap: 6,
    }}>{children}</button>
  );
}

function ModeCard({ d, icon, title, sub }) {
  const isLight = d.id === 'court';
  return (
    <button style={{
      padding: '14px 14px 12px', textAlign: 'left',
      borderRadius: d.r, border: `1px solid ${d.line}`,
      background: isLight ? d.card : d.card,
      color: d.ink, fontFamily: d.fontBody, cursor: 'pointer',
    }}>
      <div style={{ color: d.primary, marginBottom: 8 }}>{icon}</div>
      <div style={{ fontFamily: d.fontDisplay, fontWeight: 700, fontSize: 15 }}>{title}</div>
      <div style={{ fontSize: 11, color: d.inkDim, marginTop: 2 }}>{sub}</div>
    </button>
  );
}

// ── Onboarding ───────────────────────────────────────────────
function ScreenOnboarding({ d, W, H, topPad = 0, botPad = 0, step = 1 }) {
  const steps = [
    { eyebrow: '01 · CONTROLS', title: 'Drag to move,\nflick up to smash.', body: 'Your finger is your racket. Slide along the bottom to position. Power scales with flick speed.' },
    { eyebrow: '02 · THE TIN', title: 'Hit above\nthe red line.', body: 'The bottom 19cm of the front wall is the tin. Below it = point lost. Aim high, drop deep.' },
    { eyebrow: '03 · PAR 11', title: 'First to 11,\nbest of 5.', body: 'Every rally is a point. At 10-10 the game extends until someone leads by two.' },
  ];
  const s = steps[(step - 1) % 3];
  return (
    <div style={{ width: W, height: H, background: d.bg, color: d.ink, fontFamily: d.fontBody, paddingTop: topPad, paddingBottom: botPad, position: 'relative', overflow: 'hidden' }}>
      <div style={{ position: 'absolute', top: topPad + 20, left: 20, right: 20, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <BrandMark d={d} />
        <button style={{ background: 'none', border: 'none', color: d.inkDim, fontFamily: d.fontBody, fontSize: 13, cursor: 'pointer' }}>Skip</button>
      </div>

      <div style={{ position: 'absolute', top: topPad + 60, left: 0, right: 0, height: H * 0.42 }}>
        <CourtView d={d} W={W} H={H * 0.42} ball={{ x: 0.5, z: 0.25 + step * 0.15, y: 0.5 }} playerX={0.5} oppX={0.5} />
      </div>

      <div style={{ position: 'absolute', top: H * 0.58, left: 24, right: 24 }}>
        <div style={{ fontFamily: d.fontMono, fontSize: 11, letterSpacing: 2, color: d.primary }}>{s.eyebrow}</div>
        <div style={{ marginTop: 10, fontFamily: d.fontDisplay, fontSize: 30, lineHeight: 1.05, fontWeight: 800, whiteSpace: 'pre-line' }}>{s.title}</div>
        <div style={{ marginTop: 12, fontSize: 14, lineHeight: 1.4, color: d.inkDim, maxWidth: '94%' }}>{s.body}</div>
      </div>

      {/* Dots */}
      <div style={{ position: 'absolute', bottom: botPad + 80, left: 24, display: 'flex', gap: 6 }}>
        {[1,2,3].map((i) => (
          <span key={i} style={{ width: i === step ? 24 : 8, height: 8, borderRadius: 99, background: i === step ? d.primary : d.lineStrong }} />
        ))}
      </div>

      <div style={{ position: 'absolute', bottom: botPad + 20, left: 24, right: 24, display: 'flex', gap: 10 }}>
        <button style={{ flex: 1, padding: '14px', borderRadius: d.r, background: d.chip, border: `1px solid ${d.line}`, color: d.ink, fontFamily: d.fontDisplay, fontWeight: 700, fontSize: 14, cursor: 'pointer' }}>Back</button>
        <button style={{ flex: 2, padding: '14px', borderRadius: d.r, background: d.primary, border: 'none', color: d.primaryInk, fontFamily: d.fontDisplay, fontWeight: 800, fontSize: 15, letterSpacing: 0.5, cursor: 'pointer' }}>
          {step === 3 ? 'START PRACTICE' : 'NEXT'}
        </button>
      </div>
    </div>
  );
}

// ── Pause overlay (rendered over a court) ────────────────────
function ScreenPause({ d, W, H, topPad = 0, botPad = 0 }) {
  return (
    <div style={{ width: W, height: H, background: d.bg, position: 'relative', overflow: 'hidden', fontFamily: d.fontBody, color: d.ink }}>
      {/* Court behind */}
      <CourtView d={d} W={W} H={H} ball={{ x: 0.5, z: 0.5, y: 0.4 }} playerX={0.5} oppX={0.5} />
      <div style={{ position: 'absolute', inset: 0, background: 'rgba(0,0,0,0.7)', backdropFilter: 'blur(8px)' }} />

      <div style={{ position: 'absolute', top: topPad + 20, left: 20, right: 20, display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
        <div style={{ fontFamily: d.fontMono, fontSize: 11, letterSpacing: 2, color: d.inkDim }}>GAME 2 · PAUSED</div>
        <button style={{ width: 36, height: 36, borderRadius: 99, background: d.chip, border: `1px solid ${d.line}`, color: d.ink, cursor: 'pointer' }}><Icon.X s={14} /></button>
      </div>

      <div style={{ position: 'absolute', top: H * 0.18, left: 0, right: 0, textAlign: 'center', color: '#fff' }}>
        <div style={{ fontFamily: d.fontDisplay, fontSize: 64, fontWeight: 900, lineHeight: 1, letterSpacing: -1 }}>7 — 4</div>
        <div style={{ marginTop: 6, fontFamily: d.fontMono, fontSize: 11, letterSpacing: 2, color: d.inkDim }}>YOU LEAD · BEST OF 5</div>
      </div>

      <div style={{ position: 'absolute', top: H * 0.42, left: 24, right: 24, display: 'flex', flexDirection: 'column', gap: 10 }}>
        <ResumeBig d={d} />
        <RowBtn d={d} icon={<Icon.Replay s={16} />} label="Restart game" />
        <RowBtn d={d} icon={<Icon.Cog s={16} />} label="Settings" />
        <RowBtn d={d} icon={<Icon.Trophy s={16} />} label="Rules summary" />
        <RowBtn d={d} icon={<Icon.X s={16} />} label="Quit match" muted />
      </div>

      {/* Rally summary chip */}
      <div style={{ position: 'absolute', bottom: botPad + 18, left: 24, right: 24, padding: 14, borderRadius: d.r, background: 'rgba(255,255,255,0.06)', border: `1px solid ${d.line}`, color: '#fff' }}>
        <div style={{ fontSize: 11, color: d.inkDim, fontFamily: d.fontMono, letterSpacing: 1.5 }}>THIS GAME</div>
        <div style={{ display: 'flex', gap: 18, marginTop: 6, fontFamily: d.fontMono }}>
          <div><div style={{ fontSize: 20, fontWeight: 700, color: d.primary }}>11</div><div style={{ fontSize: 10, color: d.inkDim }}>RALLIES</div></div>
          <div><div style={{ fontSize: 20, fontWeight: 700 }}>4.2s</div><div style={{ fontSize: 10, color: d.inkDim }}>AVG RALLY</div></div>
          <div><div style={{ fontSize: 20, fontWeight: 700, color: d.warn }}>2</div><div style={{ fontSize: 10, color: d.inkDim }}>TINS</div></div>
        </div>
      </div>
    </div>
  );
}

function ResumeBig({ d }) {
  return (
    <button style={{ padding: '16px 18px', borderRadius: d.r, background: d.primary, color: d.primaryInk, border: 'none', display: 'flex', alignItems: 'center', justifyContent: 'space-between', cursor: 'pointer', fontFamily: d.fontDisplay, fontWeight: 800, fontSize: 17, letterSpacing: 0.5 }}>
      <span style={{ display: 'flex', alignItems: 'center', gap: 10 }}><Icon.Play s={20} /> RESUME</span>
      <span style={{ fontFamily: d.fontMono, fontSize: 11, opacity: 0.7 }}>HOLD ↩</span>
    </button>
  );
}
function RowBtn({ d, icon, label, muted }) {
  return (
    <button style={{ padding: '14px 16px', borderRadius: d.r, background: 'rgba(255,255,255,0.06)', border: `1px solid ${d.line}`, color: muted ? d.bad : '#fff', display: 'flex', alignItems: 'center', gap: 12, fontFamily: d.fontBody, fontSize: 14, fontWeight: 600, cursor: 'pointer' }}>
      {icon}<span style={{ flex: 1, textAlign: 'left' }}>{label}</span><Icon.Chevron s={16} />
    </button>
  );
}

Object.assign(window, { ScreenHome, ScreenOnboarding, ScreenPause, BrandMark, PillBtn, ModeCard, Icon });


// ─── merged from screens-extra.jsx ───

// screens-extra.jsx — Remaining screens: Post-match, Stats, Settings, Practice, Achievements

function ScreenPostMatch({ d, W, H, topPad = 0, botPad = 0 }) {
  return (
    <div style={{ width: W, height: H, background: d.bg, color: d.ink, fontFamily: d.fontBody, paddingTop: topPad, paddingBottom: botPad, position: 'relative', overflow: 'hidden' }}>
      {/* Hero banner */}
      <div style={{ position: 'absolute', top: topPad, left: 0, right: 0, height: H * 0.36, background: `linear-gradient(135deg, ${d.primary} 0%, ${d.warn} 100%)`, padding: '24px 24px 0', color: d.primaryInk, overflow: 'hidden' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <div style={{ fontFamily: d.fontMono, fontSize: 11, letterSpacing: 2 }}>MATCH · 12 MAY · 14:32</div>
          <button style={{ background: 'rgba(0,0,0,0.2)', border: 'none', borderRadius: 99, color: d.primaryInk, padding: '6px 10px', fontSize: 12, cursor: 'pointer' }}><Icon.X s={12} /></button>
        </div>
        <div style={{ marginTop: 18, fontFamily: d.fontDisplay, fontSize: 56, fontWeight: 900, letterSpacing: -1, lineHeight: 0.95 }}>WIN.</div>
        <div style={{ marginTop: 6, fontSize: 13, opacity: 0.85, maxWidth: '70%' }}>You took the match 3–1 over Pro AI. Best rally of the day: 18 shots.</div>
        {/* Decorative court silhouette */}
        <div style={{ position: 'absolute', right: -30, top: 30, opacity: 0.18 }}>
          <CourtView d={{ ...d, courtFloor: '#000', courtFloor2: '#000', courtWall: '#000', courtLine: 'rgba(0,0,0,0.6)', courtTin: '#000' }} W={180} H={180} showAvatars={false} />
        </div>
      </div>

      {/* Score breakdown */}
      <div style={{ position: 'absolute', top: H * 0.32, left: 20, right: 20, padding: 16, borderRadius: d.r, background: d.card, border: `1px solid ${d.line}` }}>
        <div style={{ display: 'grid', gridTemplateColumns: '1fr auto 1fr', alignItems: 'center', gap: 12 }}>
          <div>
            <div style={{ fontFamily: d.fontMono, fontSize: 11, color: d.inkDim, letterSpacing: 1.5 }}>YOU</div>
            <div style={{ fontFamily: d.fontDisplay, fontSize: 40, fontWeight: 800, color: d.primary }}>3</div>
          </div>
          <div style={{ color: d.inkDim, fontFamily: d.fontMono }}>vs</div>
          <div style={{ textAlign: 'right' }}>
            <div style={{ fontFamily: d.fontMono, fontSize: 11, color: d.inkDim, letterSpacing: 1.5 }}>AI · PRO</div>
            <div style={{ fontFamily: d.fontDisplay, fontSize: 40, fontWeight: 800 }}>1</div>
          </div>
        </div>
        <div style={{ marginTop: 12, display: 'grid', gridTemplateColumns: 'repeat(5, 1fr)', gap: 8 }}>
          {[['11','7'],['9','11'],['11','5'],['11','8'],['—','—']].map((g, i) => (
            <div key={i} style={{ padding: '8px 4px', borderRadius: d.rsm, background: g[0]==='—' ? 'transparent' : (parseInt(g[0])>parseInt(g[1]) ? 'rgba(198,255,61,0.08)' : 'rgba(255,81,81,0.08)'), border: `1px solid ${d.line}`, textAlign: 'center', fontFamily: d.fontMono }}>
              <div style={{ fontSize: 10, color: d.inkDim, letterSpacing: 1 }}>G{i+1}</div>
              <div style={{ fontWeight: 700, fontSize: 13, color: d.ink }}>{g[0]}–{g[1]}</div>
            </div>
          ))}
        </div>
      </div>

      {/* Stats list */}
      <div style={{ position: 'absolute', top: H * 0.58, left: 20, right: 20 }}>
        <StatBar d={d} label="Winners" you={24} opp={17} />
        <StatBar d={d} label="Unforced errors" you={9} opp={14} inverse />
        <StatBar d={d} label="Longest rally" you={18} opp={12} unit="shots" />
        <StatBar d={d} label="Avg power" you={72} opp={68} unit="%" />
      </div>

      {/* Bottom actions */}
      <div style={{ position: 'absolute', bottom: botPad + 16, left: 20, right: 20, display: 'flex', gap: 10 }}>
        <button style={{ flex: 1, padding: '14px', borderRadius: d.r, background: d.chip, border: `1px solid ${d.line}`, color: d.ink, fontFamily: d.fontDisplay, fontWeight: 700, fontSize: 13, cursor: 'pointer' }}><Icon.Share s={14} /> Share</button>
        <button style={{ flex: 2, padding: '14px', borderRadius: d.r, background: d.primary, color: d.primaryInk, border: 'none', fontFamily: d.fontDisplay, fontWeight: 800, fontSize: 14, letterSpacing: 0.5, cursor: 'pointer' }}>REMATCH</button>
      </div>
    </div>
  );
}

function StatBar({ d, label, you, opp, inverse, unit = '' }) {
  const total = Math.max(you, opp) * 1.2 + 1;
  const winning = inverse ? you < opp : you > opp;
  return (
    <div style={{ marginBottom: 10 }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: 11, color: d.inkDim, fontFamily: d.fontMono, letterSpacing: 1 }}>
        <span style={{ color: winning ? d.primary : d.inkDim, fontWeight: 700 }}>{you}{unit}</span>
        <span>{label.toUpperCase()}</span>
        <span>{opp}{unit}</span>
      </div>
      <div style={{ display: 'flex', gap: 4, marginTop: 4 }}>
        <div style={{ flex: 1, height: 6, borderRadius: 99, background: 'rgba(255,255,255,0.05)', display: 'flex', justifyContent: 'flex-end' }}>
          <div style={{ width: `${(you/total)*100}%`, background: winning ? d.primary : d.inkDim, borderRadius: 99 }} />
        </div>
        <div style={{ flex: 1, height: 6, borderRadius: 99, background: 'rgba(255,255,255,0.05)' }}>
          <div style={{ width: `${(opp/total)*100}%`, background: !winning ? d.bad : d.inkDim, borderRadius: 99 }} />
        </div>
      </div>
    </div>
  );
}

// ── Stats / History ──────────────────────────────────────────
function ScreenStats({ d, W, H, topPad = 0, botPad = 0 }) {
  const winRate = 68;
  return (
    <div style={{ width: W, height: H, background: d.bg, color: d.ink, fontFamily: d.fontBody, paddingTop: topPad, paddingBottom: botPad, position: 'relative', overflow: 'hidden' }}>
      <div style={{ padding: '20px 20px 12px', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end' }}>
        <div>
          <div style={{ fontFamily: d.fontMono, fontSize: 11, letterSpacing: 2, color: d.inkDim }}>LAST 30 DAYS</div>
          <div style={{ fontFamily: d.fontDisplay, fontSize: 26, fontWeight: 800, marginTop: 4 }}>Your form</div>
        </div>
        <button style={{ padding: '6px 10px', borderRadius: 99, background: d.chip, border: `1px solid ${d.line}`, color: d.ink, fontSize: 11, fontFamily: d.fontMono }}>MONTH ▾</button>
      </div>

      <div style={{ padding: '0 20px' }}>
        <div style={{ display: 'grid', gridTemplateColumns: '1.4fr 1fr 1fr', gap: 8 }}>
          <BigStat d={d} label="Win rate" value={`${winRate}%`} accent={d.primary} delta="+6" />
          <BigStat d={d} label="Matches" value="23" delta="" />
          <BigStat d={d} label="Streak" value="7" accent={d.warn} />
        </div>

        {/* Sparkline chart */}
        <div style={{ marginTop: 14, padding: 14, borderRadius: d.r, background: d.card, border: `1px solid ${d.line}` }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', fontFamily: d.fontMono, fontSize: 11, color: d.inkDim, letterSpacing: 1 }}>
            <span>WIN RATE</span><span>{winRate}%</span>
          </div>
          <svg width="100%" height="120" viewBox="0 0 280 120" style={{ marginTop: 8, display: 'block' }}>
            <defs>
              <linearGradient id="sl-g" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stopColor={d.primary} stopOpacity="0.4"/><stop offset="1" stopColor={d.primary} stopOpacity="0"/></linearGradient>
            </defs>
            {[20,40,60,80].map(y => <line key={y} x1="0" y1={y} x2="280" y2={y} stroke={d.line} strokeWidth="1" />)}
            <path d="M0,80 L20,75 L40,90 L60,70 L80,60 L100,72 L120,55 L140,62 L160,40 L180,48 L200,32 L220,38 L240,28 L260,30 L280,22 L280,120 L0,120 Z" fill="url(#sl-g)" />
            <path d="M0,80 L20,75 L40,90 L60,70 L80,60 L100,72 L120,55 L140,62 L160,40 L180,48 L200,32 L220,38 L240,28 L260,30 L280,22" stroke={d.primary} strokeWidth="2.5" fill="none" />
            <circle cx="280" cy="22" r="5" fill={d.primary} stroke={d.bg} strokeWidth="2" />
          </svg>
          <div style={{ display: 'flex', justifyContent: 'space-between', fontFamily: d.fontMono, fontSize: 10, color: d.inkMute, marginTop: 4 }}>
            <span>WK 1</span><span>WK 2</span><span>WK 3</span><span>WK 4</span>
          </div>
        </div>

        {/* Shot breakdown */}
        <div style={{ marginTop: 12, padding: 14, borderRadius: d.r, background: d.card, border: `1px solid ${d.line}` }}>
          <div style={{ fontFamily: d.fontMono, fontSize: 11, color: d.inkDim, letterSpacing: 1 }}>SHOT MIX</div>
          <div style={{ display: 'flex', height: 16, marginTop: 8, borderRadius: 4, overflow: 'hidden' }}>
            <div style={{ width: '42%', background: d.primary }} />
            <div style={{ width: '24%', background: d.warn }} />
            <div style={{ width: '18%', background: d.good }} />
            <div style={{ width: '16%', background: d.inkMute }} />
          </div>
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 6, marginTop: 10, fontFamily: d.fontBody, fontSize: 11 }}>
            <LegendDot c={d.primary} l="Drive" v="42%" d={d} />
            <LegendDot c={d.warn} l="Drop" v="24%" d={d} />
            <LegendDot c={d.good} l="Boast" v="18%" d={d} />
            <LegendDot c={d.inkMute} l="Lob" v="16%" d={d} />
          </div>
        </div>

        {/* Match log */}
        <div style={{ marginTop: 14, marginBottom: 6, fontFamily: d.fontMono, fontSize: 11, color: d.inkDim, letterSpacing: 1.5 }}>RECENT MATCHES</div>
        {[
          ['Today', 'AI · Pro', 'W 3-1', true],
          ['Yesterday', 'Local 2P', 'W 3-2', true],
          ['Sun 11', 'AI · Pro', 'L 1-3', false],
        ].map(([day, opp, score, won], i) => (
          <div key={i} style={{ display: 'flex', alignItems: 'center', padding: '10px 0', borderTop: `1px solid ${d.line}` }}>
            <div style={{ width: 4, height: 24, background: won ? d.primary : d.bad, marginRight: 10, borderRadius: 2 }} />
            <div style={{ flex: 1 }}>
              <div style={{ fontWeight: 600, fontSize: 13 }}>{opp}</div>
              <div style={{ fontSize: 11, color: d.inkDim }}>{day}</div>
            </div>
            <div style={{ fontFamily: d.fontMono, fontWeight: 700, color: won ? d.primary : d.bad }}>{score}</div>
          </div>
        ))}
      </div>
    </div>
  );
}

function BigStat({ d, label, value, accent, delta }) {
  return (
    <div style={{ padding: 14, borderRadius: d.r, background: d.card, border: `1px solid ${d.line}` }}>
      <div style={{ fontFamily: d.fontMono, fontSize: 10, color: d.inkDim, letterSpacing: 1.4 }}>{label.toUpperCase()}</div>
      <div style={{ display: 'flex', alignItems: 'baseline', gap: 6, marginTop: 4 }}>
        <div style={{ fontFamily: d.fontDisplay, fontSize: 24, fontWeight: 800, color: accent || d.ink, lineHeight: 1 }}>{value}</div>
        {delta && <div style={{ fontSize: 11, color: d.good, fontWeight: 600 }}>{delta}</div>}
      </div>
    </div>
  );
}
function LegendDot({ c, l, v, d }) {
  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: 6, fontSize: 11 }}>
      <span style={{ width: 8, height: 8, borderRadius: 2, background: c }} />
      <span style={{ color: d.inkDim }}>{l}</span>
      <span style={{ marginLeft: 'auto', fontFamily: d.fontMono, color: d.ink }}>{v}</span>
    </div>
  );
}

// ── Settings ─────────────────────────────────────────────────
function ScreenSettings({ d, W, H, topPad = 0, botPad = 0 }) {
  return (
    <div style={{ width: W, height: H, background: d.bg, color: d.ink, fontFamily: d.fontBody, paddingTop: topPad, paddingBottom: botPad, position: 'relative', overflow: 'hidden' }}>
      <div style={{ padding: '20px 20px 12px', display: 'flex', alignItems: 'center', gap: 12 }}>
        <button style={{ width: 36, height: 36, borderRadius: 99, background: d.chip, border: `1px solid ${d.line}`, color: d.ink, cursor: 'pointer' }}>‹</button>
        <div style={{ fontFamily: d.fontDisplay, fontSize: 22, fontWeight: 800 }}>Settings</div>
      </div>
      <div style={{ padding: '0 20px' }}>
        <SettingsGroup d={d} title="GAMEPLAY">
          <SettingRow d={d} label="Difficulty" value="Pro" />
          <SettingRow d={d} label="Game speed" value="Standard" />
          <SettingRow d={d} label="Best of" value="5 games" />
          <SettingRow d={d} label="Auto-let detection" toggle />
        </SettingsGroup>
        <SettingsGroup d={d} title="CONTROLS">
          <SettingRow d={d} label="Swing sensitivity" slider={70} />
          <SettingRow d={d} label="Joystick size" value="Medium" />
          <SettingRow d={d} label="Tilt steering" toggle off />
          <SettingRow d={d} label="Haptics" toggle />
        </SettingsGroup>
        <SettingsGroup d={d} title="DISPLAY">
          <SettingRow d={d} label="Theme" value="Dark · Pace" />
          <SettingRow d={d} label="Court view" value="Isometric" />
          <SettingRow d={d} label="High contrast" toggle off />
        </SettingsGroup>
        <SettingsGroup d={d} title="AUDIO">
          <SettingRow d={d} label="Sound effects" slider={85} />
          <SettingRow d={d} label="Crowd ambience" slider={40} />
        </SettingsGroup>
      </div>
    </div>
  );
}

function SettingsGroup({ d, title, children }) {
  return (
    <div style={{ marginTop: 16 }}>
      <div style={{ fontFamily: d.fontMono, fontSize: 11, letterSpacing: 1.5, color: d.inkDim, padding: '0 4px 8px' }}>{title}</div>
      <div style={{ borderRadius: d.r, background: d.card, border: `1px solid ${d.line}`, overflow: 'hidden' }}>
        {children}
      </div>
    </div>
  );
}
function SettingRow({ d, label, value, toggle, off, slider }) {
  return (
    <div style={{ padding: '14px 16px', display: 'flex', alignItems: 'center', borderTop: `1px solid ${d.line}` }}>
      <div style={{ flex: 1, fontSize: 14 }}>{label}</div>
      {value && <div style={{ fontFamily: d.fontMono, fontSize: 12, color: d.inkDim, display: 'flex', alignItems: 'center', gap: 6 }}>{value}<Icon.Chevron s={14} /></div>}
      {toggle && (
        <div style={{ width: 40, height: 22, borderRadius: 99, background: off ? d.chip : d.primary, padding: 2, display: 'flex', justifyContent: off ? 'flex-start' : 'flex-end', border: off ? `1px solid ${d.line}` : 'none' }}>
          <div style={{ width: 18, height: 18, borderRadius: 99, background: off ? d.inkMute : d.primaryInk }} />
        </div>
      )}
      {slider != null && (
        <div style={{ width: 120, display: 'flex', alignItems: 'center', gap: 8 }}>
          <div style={{ flex: 1, height: 4, borderRadius: 99, background: d.chip, position: 'relative' }}>
            <div style={{ position: 'absolute', left: 0, top: 0, bottom: 0, width: `${slider}%`, background: d.primary, borderRadius: 99 }} />
            <div style={{ position: 'absolute', left: `${slider}%`, top: '50%', transform: 'translate(-50%, -50%)', width: 14, height: 14, borderRadius: 99, background: d.ink, border: `2px solid ${d.primary}` }} />
          </div>
        </div>
      )}
    </div>
  );
}

// ── Practice picker ──────────────────────────────────────────
function ScreenPractice({ d, W, H, topPad = 0, botPad = 0 }) {
  const drills = [
    { title: 'Straight Drives', sub: 'Build the rail', dur: '5 min', tag: 'CORE', pct: 80 },
    { title: 'Boast & Drive', sub: 'Movement loop', dur: '8 min', tag: 'PAIR', pct: 45 },
    { title: 'Front-Wall Only', sub: 'Touch & feel', dur: '4 min', tag: 'SOLO', pct: 60 },
    { title: 'Serve Returns', sub: 'Reactive depth', dur: '6 min', tag: 'CORE', pct: 25 },
  ];
  return (
    <div style={{ width: W, height: H, background: d.bg, color: d.ink, fontFamily: d.fontBody, paddingTop: topPad, paddingBottom: botPad, position: 'relative', overflow: 'hidden' }}>
      <div style={{ padding: '20px 20px 8px', display: 'flex', alignItems: 'center', gap: 12 }}>
        <button style={{ width: 36, height: 36, borderRadius: 99, background: d.chip, border: `1px solid ${d.line}`, color: d.ink, cursor: 'pointer' }}>‹</button>
        <div>
          <div style={{ fontFamily: d.fontMono, fontSize: 11, letterSpacing: 2, color: d.inkDim }}>PRACTICE</div>
          <div style={{ fontFamily: d.fontDisplay, fontSize: 22, fontWeight: 800 }}>Sharpen up</div>
        </div>
      </div>

      {/* Featured drill */}
      <div style={{ margin: '12px 20px 0', padding: 16, borderRadius: d.r, background: `linear-gradient(135deg, ${d.primary}, ${d.warn})`, color: d.primaryInk, position: 'relative', overflow: 'hidden' }}>
        <div style={{ fontFamily: d.fontMono, fontSize: 10, letterSpacing: 2, opacity: 0.75 }}>TODAY'S FOCUS</div>
        <div style={{ marginTop: 8, fontFamily: d.fontDisplay, fontSize: 26, fontWeight: 800, lineHeight: 1.05 }}>Length & Width</div>
        <div style={{ marginTop: 6, fontSize: 13, opacity: 0.85, maxWidth: '70%' }}>10 min · Build deep rails, then redirect cross-court.</div>
        <button style={{ marginTop: 14, padding: '8px 14px', borderRadius: 99, background: d.primaryInk, color: d.primary, border: 'none', fontFamily: d.fontDisplay, fontWeight: 800, fontSize: 12, letterSpacing: 0.6, cursor: 'pointer' }}>START ›</button>
        <div style={{ position: 'absolute', right: -10, bottom: -10, opacity: 0.25 }}>
          <CourtView d={{ ...d, courtFloor: '#000', courtFloor2: '#000', courtWall: '#000', courtLine: 'rgba(0,0,0,0.6)', courtTin: '#000' }} W={130} H={120} showAvatars={false} />
        </div>
      </div>

      {/* Drill list */}
      <div style={{ padding: '16px 20px' }}>
        <div style={{ fontFamily: d.fontMono, fontSize: 11, color: d.inkDim, letterSpacing: 1.5, marginBottom: 8 }}>ALL DRILLS</div>
        {drills.map((dr, i) => (
          <div key={i} style={{ padding: '12px 14px', display: 'flex', alignItems: 'center', gap: 12, borderRadius: d.rsm, background: d.card, border: `1px solid ${d.line}`, marginBottom: 8 }}>
            <div style={{ width: 36, height: 36, borderRadius: 8, background: d.chip, display: 'grid', placeItems: 'center', color: d.primary }}><Icon.Target s={18} /></div>
            <div style={{ flex: 1, minWidth: 0 }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                <div style={{ fontSize: 14, fontWeight: 700 }}>{dr.title}</div>
                <span style={{ fontFamily: d.fontMono, fontSize: 9, padding: '2px 5px', background: d.chip, color: d.inkDim, letterSpacing: 1 }}>{dr.tag}</span>
              </div>
              <div style={{ fontSize: 11, color: d.inkDim }}>{dr.sub} · {dr.dur}</div>
              <div style={{ height: 3, marginTop: 6, background: d.chip, borderRadius: 99 }}>
                <div style={{ width: `${dr.pct}%`, height: '100%', background: d.primary, borderRadius: 99 }} />
              </div>
            </div>
            <Icon.Chevron s={16} />
          </div>
        ))}
      </div>
    </div>
  );
}

// ── Achievements ─────────────────────────────────────────────
function ScreenAchievements({ d, W, H, topPad = 0, botPad = 0 }) {
  const items = [
    { t: 'First Win', s: 'Won your first match', got: true, icon: '★' },
    { t: 'Drive Master', s: '500 drives landed', got: true, icon: '➜' },
    { t: 'Tin Avoider', s: '20 rallies, 0 tins', got: true, icon: '◆' },
    { t: 'Streak 10', s: 'Win 10 matches in a row', got: false, icon: '⚡', pct: 70 },
    { t: 'Iron Wrist', s: 'Play 50 matches', got: false, icon: '✦', pct: 46 },
    { t: 'Boast Boss', s: '100 boasts winners', got: false, icon: '↻', pct: 22 },
  ];
  return (
    <div style={{ width: W, height: H, background: d.bg, color: d.ink, fontFamily: d.fontBody, paddingTop: topPad, paddingBottom: botPad, position: 'relative', overflow: 'hidden' }}>
      <div style={{ padding: '20px 20px 0', display: 'flex', alignItems: 'center', gap: 12 }}>
        <button style={{ width: 36, height: 36, borderRadius: 99, background: d.chip, border: `1px solid ${d.line}`, color: d.ink, cursor: 'pointer' }}>‹</button>
        <div>
          <div style={{ fontFamily: d.fontMono, fontSize: 11, letterSpacing: 2, color: d.inkDim }}>PROGRESS · 14 / 40</div>
          <div style={{ fontFamily: d.fontDisplay, fontSize: 22, fontWeight: 800 }}>Achievements</div>
        </div>
      </div>
      {/* Progress ring */}
      <div style={{ display: 'flex', justifyContent: 'center', marginTop: 14 }}>
        <svg width="120" height="120" viewBox="0 0 120 120">
          <circle cx="60" cy="60" r="48" stroke={d.chip} strokeWidth="10" fill="none" />
          <circle cx="60" cy="60" r="48" stroke={d.primary} strokeWidth="10" fill="none" strokeLinecap="round"
            strokeDasharray={`${(14/40)*301} 301`} transform="rotate(-90 60 60)" />
          <text x="60" y="58" textAnchor="middle" fontFamily={d.fontDisplay} fontWeight="800" fontSize="28" fill={d.ink}>14</text>
          <text x="60" y="76" textAnchor="middle" fontFamily={d.fontMono} fontSize="10" fill={d.inkDim} letterSpacing="1.5">OF 40</text>
        </svg>
      </div>
      <div style={{ padding: '6px 20px 0', display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 8 }}>
        {items.map((a, i) => (
          <div key={i} style={{ padding: 12, borderRadius: d.rsm, background: a.got ? d.card : d.bgElev, border: `1px solid ${a.got ? d.primary : d.line}`, opacity: a.got ? 1 : 0.85, position: 'relative' }}>
            <div style={{ width: 36, height: 36, borderRadius: 8, background: a.got ? d.primary : d.chip, color: a.got ? d.primaryInk : d.inkMute, display: 'grid', placeItems: 'center', fontFamily: d.fontDisplay, fontWeight: 800, fontSize: 18 }}>{a.icon}</div>
            <div style={{ marginTop: 8, fontSize: 12, fontWeight: 700 }}>{a.t}</div>
            <div style={{ fontSize: 10, color: d.inkDim, marginTop: 2 }}>{a.s}</div>
            {!a.got && a.pct && (
              <div style={{ height: 3, marginTop: 8, background: d.chip, borderRadius: 99 }}>
                <div style={{ width: `${a.pct}%`, height: '100%', background: d.primary, borderRadius: 99 }} />
              </div>
            )}
          </div>
        ))}
      </div>
    </div>
  );
}

Object.assign(window, { ScreenPostMatch, ScreenStats, ScreenSettings, ScreenPractice, ScreenAchievements });
