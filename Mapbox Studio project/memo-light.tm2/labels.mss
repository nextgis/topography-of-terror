/* LABELS.MSS CONTENTS:
 * - place names
 * - area labels
 * - waterway labels 
 */

/* Font sets are defined in palette.mss */

/* ================================================================== */
/* PLACE NAMES
/* ================================================================== */

/* ---- Cities ------------------------------------------------------ */

#place::city[type='city'][zoom=13] {
  text-name:'[name]';
  text-face-name:@sans;
  text-placement:point;
  text-fill:@city_text;
  text-halo-fill:@city_halo;
  text-halo-radius:2;
  [zoom=13] {
    text-size:16;
    text-character-spacing: 2;
    text-wrap-width: 200;
    text-transform: uppercase;
  }
  /*[zoom=14] {
    text-size:17;
    text-character-spacing: 4;
    text-wrap-width: 300;
    text-transform: uppercase;
  }*/
}

/* ---- Towns ------------------------------------------------------- */

#place::town[type='town'][zoom>=13][zoom<=17] {
  text-name:'[name]';
  text-face-name:@sans;
  text-placement:point;
  text-fill:@town_text;
  text-size:9;
  text-halo-fill:@town_halo;
  text-halo-radius:1;
  text-wrap-width: 50;
  [zoom>=13]{
    text-transform: uppercase;
    text-character-spacing: 1;
    text-line-spacing: 2;
  }
  [zoom>=14]{
    text-size:13;
    text-character-spacing: 2;
    text-line-spacing: 3;
  }
  [zoom>=15]{
    text-size:14;
    text-character-spacing: 3;
    text-line-spacing: 4;
  }
  [zoom>=15]{
    text-size:15;
    text-character-spacing: 4;
    text-line-spacing: 5;
  }
  [zoom>=17]{
    text-size:16;
    text-character-spacing: 5;
    text-line-spacing: 6;
  }
}

/* ---- Other small places ------------------------------------------ */

#place::small[type='village'][zoom>=13][zoom<=14],
/*#place::small[type='suburb'][zoom>=13][zoom<=14],*/
#place::small[type='hamlet'][zoom>=13][zoom<=14],
/*#place::small[type='neighbourhood'][zoom>=13][zoom<=14]*/ {
  text-name:'[name]';
  text-face-name:@sans;
  text-placement:point;
  text-fill:@other_text;
  text-size:10;
  text-halo-fill:@other_halo;
  text-halo-radius:1.5;
  text-wrap-width: 30;
  [zoom>=14] {
    text-size:11;
    text-character-spacing: 1;
    text-wrap-width: 40;
    text-line-spacing: 1;
  }
  [zoom>=15] {
    text-halo-radius: 2;
    text-transform: uppercase;
    text-character-spacing: 1;
    text-wrap-width: 60; 
    text-line-spacing: 1;
  }
  [zoom>=16] {
    text-size:12;
    text-character-spacing: 2;
    text-wrap-width: 120;
    text-line-spacing: 2;
  } 
  [zoom>=17] {
    text-size:13; 
    text-character-spacing: 3;
    text-wrap-width: 160;
    text-line-spacing: 4;
  }
  /*
  [zoom>=18] {
    text-size:14;
    text-character-spacing: 4;
    text-line-spacing: 6;
  }
  */
}

#place::small[type='locality'][zoom>=15] {
  text-name:'[name]';
  text-face-name:@sans;
  text-placement:point;
  text-fill:@locality_text;
  text-size:9;
  text-halo-fill:@locality_halo;
  text-halo-radius:1;
  text-wrap-width: 30;
  [zoom>=16] {
    text-size:10;
    text-wrap-width: 60;
    text-line-spacing: 1;
  }
  [zoom>=17] {
    text-size:11;
    text-wrap-width: 120;
    text-line-spacing: 2;
  }
  /*
  [zoom>=18] {
    text-size:12;
    text-character-spacing: 1;
    text-line-spacing: 4;
  }
  */
}


// =====================================================================
// AREA LABELS
// =====================================================================
#area_label[type='park'],
#area_label[type='nature_reserve'],
#area_label[type='cemetery'],
#area_label[type='water'] {
  // Bring in labels gradually as one zooms in, bases on polygon area
  //[zoom>=10][area>102400000],
  //[zoom>=11][area>25600000],
  [zoom>=13][area>1600000],
  [zoom>=14][area>320000],
  [zoom>=15][area>80000],
  [zoom>=16][area>20000],
  [zoom>=17][area>5000]
  /*[zoom>=18][area>=0]*/ {
    text-name: "[name]";
    text-halo-radius: 1.5;
    text-face-name:@sans;
    text-size: 11;
    text-wrap-width:30;
    text-fill: @other_text;
    text-halo-fill: @other_halo;
    // Specific style overrides for different types of areas:
    [type='park'][zoom>=10],
    [type='nature_reserve'][zoom>=10]  {       
      text-face-name: @sans_italic;
      text-fill: @park * 0.3;
      text-halo-fill: lighten(@park, 10);
    }
    /*[type='golf_course'][zoom>=10] {
      text-fill: @sports * 0.6;
      text-halo-fill: lighten(@sports, 10);
    }*/
    [type='cemetery'][zoom>=10] {       
      text-fill: @cemetery * 0.6;
      text-halo-fill: lighten(@cemetery, 10);
    }
    /*[type='hospital'][zoom>=10] {
      text-fill: @hospital * 0.6;
      text-halo-fill: lighten(@hospital, 10);
    }
    [type='college'][zoom>=10],
    [type='school'][zoom>=10],
    [type='university'][zoom>=10] {
      text-fill: @school * 0.6;
      text-halo-fill: lighten(@school, 10);
    }*/
    [type='water'][zoom>=10] {         
      text-fill: @water * 0.6;
      text-halo-fill: lighten(@water, 10);
    }
  }
  [zoom=15][area>1600000],
  [zoom=16][area>80000],
  [zoom=17][area>20000]
  /*[zoom=18][area>5000]*/ {
    text-name: "[name]";
    text-size: 13;
    text-wrap-width: 60;
    text-character-spacing: 1;
    text-halo-radius: 1.5;
  }
  [zoom=16][area>1600000],
  [zoom=17][area>80000]
  /*[zoom=18][area>20000]*/ {
    text-size: 15;
    text-character-spacing: 2;
    text-wrap-width: 120;
  }
  [zoom>=17][area>1600000]
  /*[zoom>=18][area>80000]*/ {
    text-size: 20;
    text-character-spacing: 3;
    text-wrap-width: 180;
  }
}

/* ================================================================== */
/* WATERWAY LABELS
/* ================================================================== */

/*#waterway_label[type='river'][zoom>=13],
#waterway_label[type='canal'][zoom>=15],
#waterway_label[type='stream'][zoom>=17]*/
#waterway_label[type='river'][zoom>=16],
#waterway_label[type='canal'][zoom>=16],
#waterway_label[type='stream'][zoom>=17]{
  text-name: '[name]';
  text-face-name: @sans_italic;
  text-fill: lighten(@water,25);
  text-halo-fill: darken(@water,10);
  text-halo-radius: 1;
  text-placement: line;
  //text-min-distance: 150;
  text-size: 10;
  text-character-spacing: 1;
  text-avoid-edges: true;
  [type='river'][zoom=15],
  [type='canal'][zoom=17] {
    text-size: 11;
  }
  [type='river'][zoom>=16]
  /*[type='canal'][zoom=18]*/ {
    text-size: 14;
    text-spacing: 300;
  }
}

/* ================================================================== */
/* ROAD LABELS
/* ================================================================== */
#motorway_label[type='motorway'][zoom>=13],
#motorway_label[type='trunk'][zoom>=13] {
  text-name:[name];
  text-face-name:@sans_bold;
  text-placement:line;
  text-fill:@road_text;
  text-halo-fill:@road_halo;
  text-halo-radius:1.5;
  text-min-distance:115;
  text-spacing: 115;
  text-character-spacing: 1;
  text-size:11;
  text-avoid-edges: true;
}

#mainroad_label[type='primary'][zoom>=13],
#mainroad_label[type='secondary'][zoom>=13],
#mainroad_label[type='tertiary'][zoom>=13] {
  text-name:[name];
  text-face-name:@sans;
  text-placement:line;
  text-wrap-character: "|";
  text-wrap-width: 105;
  //text-wrap-before: true;
  text-fill:@road_text;
  text-halo-fill:@road_halo;
  text-halo-radius:1;
  text-min-distance:65;
  text-spacing: 65;
  text-character-spacing: 1;
  text-size:11;
  text-avoid-edges: true;
}

#minorroad_label[zoom>14] {
  text-name:[name];
  text-face-name:@sans;
  text-placement:line;
  text-wrap-character: "|";
  //text-wrap-before: true;
  text-wrap-width: 105;
  //text-allow-overlap: true;
  text-size:10;
  text-fill:@road_text;
  text-halo-fill:@road_halo;
  text-halo-radius:1;
  text-min-distance:65;
  text-spacing: 65;
  //text-character-spacing: 1;
  text-avoid-edges: true;
}

/* ****************************************************************** */