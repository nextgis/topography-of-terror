/* ================================================================== */
/* FONTS
/* ================================================================== */

/* directory to load fonts from in addition to the system directories */
Map { font-directory: url(./fonts); }

/* set up font sets for various weights and styles */
@sans:              "Open Sans Semibold","Arial Unicode MS Regular";
@sans_italic:       "Open Sans Semibold Italic","Arial Unicode MS Regular";
@sans_bold:         "Open Sans Bold","Arial Unicode MS Regular";

/* Some fonts are larger or smaller than others. Use this variable to
   globally increase or decrease the font sizes. */
/* Note this is only implemented for certain things so far */
@text_adjust: 0;

/* ================================================================== */
/* LANDUSE & LANDCOVER COLORS
/* ================================================================== */

@land:              #DBDCDE;
@water:             #5280A2;
@grass:             @park;
@beach:             #FFEEC7;
@park:              #798F69;
@cemetery:          @park;
@wooded:            @park;
@agriculture:       #96000e;

@building:          #BCB5A5;
@hospital:          @land;
@school:            @land;
@sports:            @park;

@residential:       @land;
@commercial:        @land;
@industrial:        @land;
@parking:           @land;

/* ================================================================== */
/* ROAD COLORS
/* ================================================================== */

/* For each class of road there are three color variables:
 * - line: for lower zoomlevels when the road is represented by a
 *         single solid line.
 * - case: for higher zoomlevels, this color is for the road's
 *         casing (outline).
 * - fill: for higher zoomlevels, this color is for the road's
 *         inner fill (inline).
 */

@motorway_line:     #AEADAB;
@motorway_fill:     lighten(@motorway_line,10%);
@motorway_case:     @motorway_line * 0.9;

@trunk_line:        #AEADAB;
@trunk_fill:        lighten(@trunk_line,10%);
@trunk_case:        @trunk_line * 0.9;

@primary_line:      #AEADAB;
@primary_fill:      lighten(@primary_line,10%);
@primary_case:      @primary_line * 0.9;

@secondary_line:    #AEADAB;
@secondary_fill:    lighten(@secondary_line,10%);
@secondary_case:    @secondary_line * 0.9;

@standard_line:     @land * 0.85;
@standard_fill:     #AEADAB;
@standard_case:     @land * 0.9;

@pedestrian_line:   @standard_line;
@pedestrian_fill:   #AEADAB;
@pedestrian_case:   @land;

@cycle_line:        @standard_line;
@cycle_fill:        #AEADAB;
@cycle_case:        @land;

@rail_line:         #999;
@rail_fill:         #fff;
@rail_case:         @land;

@aeroway:           #ddd;

/* ================================================================== */
/* BOUNDARY COLORS
/* ================================================================== */

@admin_2:           #324;

/* ================================================================== */
/* LABEL COLORS
/* ================================================================== */

/* We set up a default halo color for places so you can edit them all
   at once or override each individually. */
@place_halo:        fadeout(#fff,14%);

@city_text:         #444;
@city_halo:         @place_halo;

@town_text:         #444;
@town_halo:         @place_halo;

@road_text:         #333;
@road_halo:         #AEADAB;

@other_text:        #555;
@other_halo:        @place_halo;

@locality_text:     #555;
@locality_halo:     @land;

/* Also used for other small places: hamlets, suburbs, localities */
@village_text:      #555;
@village_halo:      @place_halo;

/* ****************************************************************** */