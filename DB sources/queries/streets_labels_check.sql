/*
 SELECT ST_LineMerge(ST_Union(way)) as way, type, name
  FROM
    ( SELECT way, type, COALESCE(both_names, name) AS name
     FROM
       ( SELECT way, highway AS type, name
         FROM planet_osm_line
         WHERE (name IS NOT NULL)
           AND highway IN ('residential', 'unclassified', 'road', 'living_street', 'unknown')
       ) AS osm_line
     LEFT JOIN streets_names ON (lower(regexp_replace(osm_line.name, '\s*(улица|площадь|переулок|проезд|бульвар|набережная|шоссе)\s*', '')) = lower(regexp_replace(streets_names.modern_name, '\s*(улица|площадь|переулок|проезд|бульвар|набережная|шоссе)\s*', '')))
    ) AS streets_labels
  GROUP BY name, type;
*/
/*
 SELECT ST_LineMerge(ST_Union(way)) as way, type, name
  FROM
    ( SELECT way, type, COALESCE(both_names, name) AS name
     FROM
       ( SELECT way, highway AS type, name
         FROM planet_osm_line
         WHERE (name IS NOT NULL)
           AND highway IN ('primary', 'secondary', 'tertiary')
       ) AS osm_line
     LEFT JOIN streets_names ON (lower(regexp_replace(osm_line.name, '\s*(улица|площадь|переулок|проезд|бульвар|набережная|шоссе)\s*', '')) = lower(regexp_replace(streets_names.modern_name, '\s*(улица|площадь|переулок|проезд|бульвар|набережная|шоссе)\s*', '')))
    ) AS streets_labels
  GROUP BY name, type;
*/
/*
 SELECT ST_LineMerge(ST_Union(way)) as way, type, name
  FROM
    ( SELECT way, type, COALESCE(both_names, name) AS name
     FROM
       ( SELECT way, highway AS type, name
         FROM planet_osm_line
         WHERE (name IS NOT NULL)
           AND highway IN ('motorway', 'trunk')
       ) AS osm_line
     LEFT JOIN streets_names ON (lower(regexp_replace(osm_line.name, '\s*(улица|площадь|переулок|проезд|бульвар|набережная|шоссе)\s*', '')) = lower(regexp_replace(streets_names.modern_name, '\s*(улица|площадь|переулок|проезд|бульвар|набережная|шоссе)\s*', '')))
    ) AS streets_labels
  GROUP BY name, type;
*/