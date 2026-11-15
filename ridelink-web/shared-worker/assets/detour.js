// Highlight portions of a route with stops that are away from the original route.
// The small tolerance absorbs minor geometry differences between OSRM responses.
function findDetourSegments(base, via) {
  const cell = 0.02, toleranceMiles = 0.06, grid = new Map();
  const key = (x, y) => x + ',' + y;
  for (let i = 1; i < base.length; i++) {
    const a = base[i - 1], b = base[i];
    const steps = Math.max(1, Math.ceil(Math.max(Math.abs(b[0]-a[0]), Math.abs(b[1]-a[1])) / (cell / 2)));
    const seen = new Set();
    for (let j = 0; j <= steps; j++) {
      const t = j / steps, k = key(Math.floor((a[0]+t*(b[0]-a[0]))/cell), Math.floor((a[1]+t*(b[1]-a[1]))/cell));
      if (!seen.has(k)) { if (!grid.has(k)) grid.set(k, []); grid.get(k).push([a, b]); seen.add(k); }
    }
  }
  function away(p) {
    const x = Math.floor(p[0]/cell), y = Math.floor(p[1]/cell), kx = 69.172*Math.cos(p[1]*Math.PI/180), ky = 69;
    for (let dx = -1; dx <= 1; dx++) for (let dy = -1; dy <= 1; dy++) {
      for (const [a,b] of grid.get(key(x+dx,y+dy)) || []) {
        const vx=(b[0]-a[0])*kx, vy=(b[1]-a[1])*ky, px=(p[0]-a[0])*kx, py=(p[1]-a[1])*ky, len=vx*vx+vy*vy;
        const t=len ? Math.max(0,Math.min(1,(px*vx+py*vy)/len)) : 0;
        if (Math.hypot(px-t*vx,py-t*vy)<=toleranceMiles) return false;
      }
    }
    return true;
  }
  const features = []; let run = null;
  for (let i=1;i<via.length;i++) {
    const a=via[i-1], b=via[i], steps=Math.max(1,Math.ceil(Math.max(Math.abs(b[0]-a[0]),Math.abs(b[1]-a[1]))/(cell/2)));
    for (let j=0;j<steps;j++) {
      const point=t=>[a[0]+t*(b[0]-a[0]),a[1]+t*(b[1]-a[1])], start=point(j/steps), end=point((j+1)/steps);
      if (away(point((j+0.5)/steps))) { if (!run) run=[start]; run.push(end); }
      else if (run) { features.push({type:'Feature',properties:{},geometry:{type:'LineString',coordinates:run}}); run=null; }
    }
  }
  if (run) features.push({type:'Feature',properties:{},geometry:{type:'LineString',coordinates:run}});
  return {type:'FeatureCollection',features};
}
