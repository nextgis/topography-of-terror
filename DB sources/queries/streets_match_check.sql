/*  Street's names which have no matches in OSM  */
SELECT modern_name FROM streets_names
  WHERE NOT EXISTS (
    SELECT highway, name FROM moscow_osm_line
    WHERE (name IS NOT NULL)
    AND (highway IS NOT NULL)
    AND (streets_names.modern_name = moscow_osm_line.name)
    AND (lower(regexp_replace(moscow_osm_line.name, '\s*(улица|площадь|переулок|проезд|бульвар|набережная|шоссе)\s*', '')) = lower(regexp_replace(streets_names.modern_name, '\s*(улица|площадь|переулок|проезд|бульвар|набережная|шоссе)\s*', '')))
    );