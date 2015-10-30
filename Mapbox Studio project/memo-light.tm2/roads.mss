/* ==================================================================
   ROAD & RAIL LINES
/* ================================================================== */

/* At higher levels the roads become more complex. We're now showing 
more than just automobile routes - railways, footways, and cycleways
come in as well.

/* Road width variables that are used in road & bridge styles */
@rdz13_maj: 3;   @rdz13_med: 1.5; @rdz13_min: 1;
@rdz14_maj: 4;   @rdz14_med: 2.5; @rdz14_min: 1.6;
@rdz15_maj: 6;   @rdz15_med: 4;   @rdz15_min: 2;
@rdz16_maj: 8;   @rdz16_med: 6;   @rdz16_min: 4;
@rdz17_maj: 14;  @rdz17_med: 12;  @rdz17_min: 10;
@rdz18_maj: 20;  @rdz18_med: 17;  @rdz18_min: 14;

/* Subway tunnels removed */
#roads_high[zoom>=13][zoom<=18],
#tunnel[type!='subway'][render='3_inline'][zoom>=13][zoom<=18],
#bridge[render='3_inline'][zoom>=13][zoom<=18]{
  /* -- colors & styles -- */
  line-color: @standard_fill;
  [type='motorway'],
  [type='motorway_link'] {
    line-color: @motorway_fill;
    [tunnel=1] { line-color: lighten(@motorway_fill, 3%); }
  }
  [type='trunk'],
  [type='trunk_link'] {
    line-color: @trunk_fill;
    [tunnel=1] { line-color: lighten(@trunk_fill, 3%); }
  }
  [type='primary'],
  [type='primary_link'] {
    line-color: @primary_fill;
    [tunnel=1] { line-color: lighten(@primary_fill, 3%); }
  }
  [type='secondary'],
  [type='secondary_link'] {
    line-color: @secondary_fill;
    [tunnel=1] { line-color: lighten(@secondary_fill, 3%); }
  }
  [stylegroup='railway'] {
    line-color: @rail_line;
    line-dasharray: 1,1;
    [type='subway'] { line-opacity: 0.67; }
    [zoom>15] { line-dasharray: 1,2; } 
  }
  [stylegroup='noauto'],
  [stylegroup='service'],
  [stylegroup='minorroad'] {
    line-width: 0;
  }
  [stylegroup='service'],
  [stylegroup='minorroad'],
  [stylegroup='mainroad'],
  [stylegroup='motorway'] {
    line-cap: round;
    line-join: round;
  }
  [stylegroup='noauto'] {
    line-join: round;
  }
  [tunnel=1] {
    line-cap: butt;
  }
  /* -- widths -- */
  [zoom=13] {
    [stylegroup='motorway'] { line-width: @rdz13_maj; }
    [stylegroup='mainroad'] { line-width: @rdz13_med; }
    [stylegroup='minorroad']{ line-width: @rdz13_min; }
    [stylegroup='service']  { line-width: @rdz13_min / 3; }
    [stylegroup='noauto']   { line-width: @rdz13_min / 4; line-dasharray: 1,1; }
    [stylegroup='railway']  { line-width: 0.8; }
  }
  [zoom=14] {
    [stylegroup='motorway'] { line-width: @rdz14_maj; }
    [stylegroup='mainroad'] { line-width: @rdz14_med; }
    [stylegroup='minorroad']{ line-width: @rdz14_min; }
    [stylegroup='service']  { line-width: @rdz14_min / 3; }
    [stylegroup='noauto']   { line-width: @rdz14_min / 4; line-dasharray: 1,1; }
    [stylegroup='railway']  { line-width: 1; }
  }
  [zoom=15] {
    [stylegroup='motorway'] { line-width: @rdz15_maj; }
    [stylegroup='mainroad'] { line-width: @rdz15_med; }
    [stylegroup='minorroad']{ line-width: @rdz15_min; }
    [stylegroup='service']  { line-width: @rdz15_min / 3; }
    [stylegroup='noauto']   { line-width: @rdz15_min / 4; line-dasharray: 1,1; }
    [stylegroup='railway']  { line-width: 1.5; }
  }
  [zoom=16] {
    [stylegroup='motorway'] { line-width: @rdz16_maj; }
    [stylegroup='mainroad'] { line-width: @rdz16_med; }
    [stylegroup='minorroad']{ line-width: @rdz16_min; }
    [stylegroup='service']  { line-width: @rdz16_min / 3; }
    [stylegroup='noauto']   { line-width: @rdz16_min / 4; line-dasharray: 2,1; }
    [stylegroup='railway']  { line-width: 2; }
  }
  [zoom=17] {
    [stylegroup='motorway'] { line-width: @rdz17_maj; }
    [stylegroup='mainroad'] { line-width: @rdz17_med; }
    [stylegroup='minorroad']{ line-width: @rdz17_min; }
    [stylegroup='service']  { line-width: @rdz17_min / 3; }
    [stylegroup='noauto']   { line-width: @rdz17_min / 4; line-dasharray: 2,2; }
    [stylegroup='railway']  { line-width: 3; }
  }
  [zoom>=18] {
    [stylegroup='motorway'] { line-width: @rdz18_maj; }
    [stylegroup='mainroad'] { line-width: @rdz18_med; }
    [stylegroup='minorroad']{ line-width: @rdz18_min; }
    [stylegroup='service']  { line-width: @rdz18_min / 2; }
    [stylegroup='noauto']   { line-width: @rdz18_min / 4; line-dasharray: 3,3; }
    [stylegroup='railway']  { line-width: 4; }
  }
}

/* ---- Bridge fill for dashed lines -------------------------------- */
/* Subway tunnels removed */
#tunnel[type!='subway'][render='2_line'][zoom>=14][zoom<=18],
#bridge[render='2_line'][zoom>=14][zoom<=18]{
  /* -- colors & styles -- */
  [stylegroup='noauto'] {
    line-color: @land;
    line-width: 0;
    line-join: round;
  }
  [stylegroup='railway'] {
    line-color: @land;
    line-join: round;
  }
  /* -- widths -- */
  [zoom=14] {
    [stylegroup='noauto']   { line-width: @rdz14_min / 4 + 1; }
    [stylegroup='railway']  { line-width: 1 + 1; }
  }
  [zoom=15] {
    [stylegroup='noauto']   { line-width: @rdz15_min / 4 + 1; }
    [stylegroup='railway']  { line-width: 1.5 + 1; }
  }
  [zoom=16] {
    [stylegroup='noauto']   { line-width: @rdz16_min / 4 + 1; }
    [stylegroup='railway']  { line-width: 2 + 1; }
  }
  [zoom=17] {
    [stylegroup='noauto']   { line-width: @rdz17_min / 4 + 3; }
    [stylegroup='railway']  { line-width: 3 + 2; }
  }
  [zoom>=18] {
    [stylegroup='noauto']   { line-width: @rdz18_min / 4 + 3; }
    [stylegroup='railway']  { line-width: 4 + 3; }
  }
}

/* ---- Turning Circles --------------------------------------------- */
#turning_circle_case[zoom>=14] {
  marker-fill:@standard_fill;
  marker-line-color:@standard_case;
  marker-line-width:2;
  marker-allow-overlap:true;
}
#turning_circle_fill[zoom>=14] {
  marker-fill:@standard_fill;
  marker-line-width:0;
  marker-line-opacity:0;
  marker-allow-overlap:true;
}
#turning_circle_case,
#turning_circle_fill {
  [zoom=14] { marker-width:@rdz14_min * 1.1; }
  [zoom=15] { marker-width:@rdz15_min * 1.1; }
  [zoom=16] { marker-width:@rdz16_min * 1.1; }
  [zoom=17] { marker-width:@rdz17_min * 1.1; }
  [zoom>=18] { marker-width:@rdz18_min * 1.1; }
}

/* ================================================================== */
/* AEROWAYS
/* ================================================================== */

#aeroway[zoom>=13] {
  line-color:@aeroway;
  line-cap:butt;
  line-join:miter;
  [type='runway'] {
    [zoom=13]{ line-width:5; }
    [zoom=14]{ line-width:7; }
    [zoom=15]{ line-width:11; }
    [zoom=16]{ line-width:15; }
    [zoom=17]{ line-width:19; }
    [zoom>17]{ line-width:23; }
  }
  [type='taxiway'] {
    [zoom=13]{ line-width:1; }
    [zoom=14]{ line-width:1.5; }
    [zoom=15]{ line-width:2; }
    [zoom=16]{ line-width:3; }
    [zoom=17]{ line-width:4; }
    [zoom>17]{ line-width:5; }
  }
}

/* ***************************************************************** */