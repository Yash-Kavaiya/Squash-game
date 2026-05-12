// tokens.jsx — Three visual directions for Squash Clash
// Each direction is a full token set used by every screen.
// Direction A "Pace" is the primary (default) — Strava-style athletic minimalism.

const DIR_PACE = {
  id: 'pace',
  name: 'Pace',
  tagline: 'Strava-style athletic minimalism',
  // Surfaces
  bg: '#0B0F10',
  bgElev: '#13191B',
  card: '#1B2224',
  cardHi: '#222B2D',
  line: 'rgba(255,255,255,0.07)',
  lineStrong: 'rgba(255,255,255,0.14)',
  // Ink
  ink: '#FFFFFF',
  inkDim: '#B4BCBE',
  inkMute: '#6E7779',
  // Brand
  primary: '#C6FF3D',     // electric lime
  primaryInk: '#0B1100',
  good: '#39E07B',
  bad: '#FF5151',
  warn: '#FFB23D',
  // Court
  courtFloor: '#6B8E32',
  courtFloor2: '#5C7D2A',
  courtWall: '#E9E4D6',
  courtLine: '#C8392E',
  courtTin: '#1F1A14',
  // Type
  fontDisplay: '"Inter", system-ui, sans-serif',
  fontBody: '"Inter", system-ui, sans-serif',
  fontMono: '"Geist Mono", ui-monospace, monospace',
  // Radii / spacing
  r: 16, rsm: 10, rxs: 6, rlg: 24,
  // Tone
  chip: 'rgba(255,255,255,0.06)',
};

const DIR_STADIUM = {
  id: 'stadium',
  name: 'Stadium',
  tagline: 'Editorial sports magazine drama',
  bg: '#0A0A0A',
  bgElev: '#111111',
  card: '#161616',
  cardHi: '#1E1E1E',
  line: 'rgba(255,255,255,0.08)',
  lineStrong: 'rgba(255,255,255,0.18)',
  ink: '#FFFFFF',
  inkDim: '#A8A8A8',
  inkMute: '#6A6A6A',
  primary: '#FF4D14',
  primaryInk: '#FFFFFF',
  good: '#22D27A',
  bad: '#FF3B3B',
  warn: '#FFB100',
  courtFloor: '#8A5A2C',
  courtFloor2: '#724720',
  courtWall: '#E5DDC9',
  courtLine: '#FFFFFF',
  courtTin: '#1A1208',
  fontDisplay: '"Bebas Neue", "Inter", sans-serif',
  fontBody: '"Manrope", system-ui, sans-serif',
  fontMono: '"Geist Mono", ui-monospace, monospace',
  r: 4, rsm: 2, rxs: 2, rlg: 8,
  chip: 'rgba(255,255,255,0.08)',
};

const DIR_COURT = {
  id: 'court',
  name: 'Court',
  tagline: 'Warm heritage club, daylight',
  bg: '#F2EBDD',
  bgElev: '#FFFFFF',
  card: '#FFFFFF',
  cardHi: '#FAF5E9',
  line: 'rgba(20,17,13,0.08)',
  lineStrong: 'rgba(20,17,13,0.18)',
  ink: '#14110D',
  inkDim: '#5A544A',
  inkMute: '#8B8579',
  primary: '#C8392E',
  primaryInk: '#FFFFFF',
  good: '#1F8A4C',
  bad: '#C8392E',
  warn: '#C7841F',
  courtFloor: '#D4B785',
  courtFloor2: '#C2A26A',
  courtWall: '#FFFFFF',
  courtLine: '#C8392E',
  courtTin: '#2A1F12',
  fontDisplay: '"Playfair Display", Georgia, serif',
  fontBody: '"Space Grotesk", system-ui, sans-serif',
  fontMono: '"Geist Mono", ui-monospace, monospace',
  r: 20, rsm: 14, rxs: 8, rlg: 28,
  chip: 'rgba(20,17,13,0.05)',
};

const DIRECTIONS = { pace: DIR_PACE, stadium: DIR_STADIUM, court: DIR_COURT };

// Helper: returns inline style props for an HTML element scoped to a direction.
function dirStyle(d, extra = {}) {
  return {
    background: d.bg,
    color: d.ink,
    fontFamily: d.fontBody,
    ...extra,
  };
}

Object.assign(window, { DIRECTIONS, DIR_PACE, DIR_STADIUM, DIR_COURT, dirStyle });
