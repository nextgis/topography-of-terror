 #!/bin/bash 

osm2pgsql -c --multi-geometry --slim --drop -d memodb -U memouser -W -H localhost --cache 3500 -S memo.style moscow_russia_12-04-15.osm.pbf