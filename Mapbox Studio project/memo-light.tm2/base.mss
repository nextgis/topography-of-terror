/* BASE.MSS CONTENTS
 * - Landuse & landcover
 * - Water areas
 * - Water ways
 * - Administrative Boundaries
 *
 */

Map {
  background-color: @land;
}

/* ================================================================== */
/* LANDUSE & LANDCOVER
/* ================================================================== */

#landuse[zoom>=13] {
  [type='cemetery']      { polygon-fill: @cemetery; }
  [type='common']        { polygon-fill: @park; }
  [type='forest']        { polygon-fill: @wooded; }
  [type='golf_course']   { polygon-fill: @sports; }
  [type='grass']         { polygon-fill: @grass; }
  [type='park']          { polygon-fill: @park; }
  [type='pedestrian']    { polygon-fill: @pedestrian_fill; }
  [type='pitch']         { polygon-fill: @sports; }
  [type='sports_center'] { polygon-fill: @sports; }
  [type='stadium']       { polygon-fill: @sports; }
  [type='wood']          { polygon-fill: @wooded; }
}

#landuse_overlays[type='nature_reserve'][zoom>=13] {
  line-color: darken(@wooded,25%);
  line-opacity:  0.3;
  line-dasharray: 1,1;
  polygon-fill: darken(@wooded,25%);
  polygon-opacity: 0.1;
  line-width: 2.0;
}

/* ---- BUILDINGS ---- */
#buildings[zoom>=14][zoom<=16] {
  polygon-fill:@building;
  [zoom>=14] {
    line-color:darken(@building,5%);
    line-width:0.2;
  }
  [zoom>=16] {
    line-color:darken(@building,10%);
    line-width:0.4;
  }
}
// At the highest zoom levels, render buildings in fancy pseudo-3D.
// Ordering polygons by their Y-position is necessary for this effect
// so we use a separate layer that does this for us.
#buildings[zoom>=17][type != 'hedge'] {
  building-fill:@building;
  building-height:1.25;
}

#buildings[zoom>=17][type = 'hedge'] {
  building-fill:@wooded;
  building-height:1.25;
}

/* ================================================================== */
/* WATER AREAS
/* ================================================================== */

#water[zoom>=13] {
  polygon-fill: @water;
}

/* ================================================================== */
/* WATER WAYS
/* ================================================================== */
#waterway_med[zoom>=13][zoom<=14] {
  line-color: @water;
  [type='river'],
  [type='canal'] {
    line-cap: round;
    line-join: round;
    [zoom=13]{ line-width: 1; }
    [zoom=14]{ line-width: 1.5; }
  }
  [type='stream'] {
    [zoom=13]{ line-width: 0.2; }
    [zoom=14]{ line-width: 0.4; }
  }
}
  
#waterway_high[zoom>=15][zoom<=18] {
  line-color: @water;
  [type='river'],
  [type='canal'] {
    line-cap: round;
    line-join: round;
    [zoom=15]{ line-width: 2; }
    [zoom=16]{ line-width: 3; }
    [zoom=17]{ line-width: 4; }
    //[zoom=18]{ line-width: 5; }
  }
  [type='stream'] {
    [zoom=15]{ line-width: 0.6; }
    [zoom=16]{ line-width: 0.8; }
    [zoom=17]{ line-width: 1; }
    [zoom=18]{ line-width: 1.5; }
  }
}
/* ================================================================== */