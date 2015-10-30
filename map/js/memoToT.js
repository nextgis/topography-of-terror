var tilesUrl = 'http://api.tiles.mapbox.com/v4/polivanov.2677b958/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoicG9saXZhbm92IiwiYSI6InNOeW1WcFEifQ.DYqShhzXKAthxYTzfSgswA',
//'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
	//Resource id здесь указывается для стиля MapServer
	layer01 = 'http://176.9.38.120/memo2/resource/26/tms?z={z}&x={x}&y={y}',
	layer02 = 'http://176.9.38.120/memo2/resource/36/tms?z={z}&x={x}&y={y}',
	layer03 = 'http://176.9.38.120/memo2/resource/38/tms?z={z}&x={x}&y={y}',
	layer04 = 'http://176.9.38.120/memo2/resource/40/tms?z={z}&x={x}&y={y}',
	layer05 = 'http://176.9.38.120/memo2/resource/34/tms?z={z}&x={x}&y={y}',
	attrib = '<a href="http://nextgis.ru/">NextGIS</a> | <a href="http://openstreetmap.org/copyright">OpenStreetMap</a> contributors';

//Proxies for NGW API
var urlIdentify = 'http://topos.memo.ru/identify',
    urlLayers = 'http://topos.memo.ru/layers/',
    urlAPI = 'http://topos.memo.ru/sources/';


var layer01ReqMeta = $.get('http://topos.memo.ru/sources/25'),
	layer01ReqFeatures = $.get('http://topos.memo.ru/sources/25/feature/'),
	layer02ReqMeta = $.get('http://topos.memo.ru/sources/35'),
	layer02ReqFeatures = $.get('http://topos.memo.ru/sources/35/feature/'),
	layer03ReqMeta = $.get('http://topos.memo.ru/sources/37'),
	layer03ReqFeatures = $.get('http://topos.memo.ru/sources/37/feature/'),
	layer04ReqMeta = $.get('http://topos.memo.ru/sources/39'),
	layer04ReqFeatures = $.get('http://topos.memo.ru/sources/39/feature/'),
	layer05ReqMeta = $.get('http://topos.memo.ru/sources/33'),
	layer05ReqFeatures = $.get('http://topos.memo.ru/sources/33/feature/');



$.when(layer01ReqMeta, layer02ReqMeta, layer03ReqMeta, layer04ReqMeta, layer05ReqMeta, layer01ReqFeatures, layer02ReqFeatures, layer03ReqFeatures, layer04ReqFeatures, layer05ReqFeatures).done(function (r1, r2, r3, r4, r5, r6, r7, r8, r9, r10) {
	//Process results
	createMainMap(r1[0], r2[0], r3[0], r4[0], r5[0], r6[0], r7[0], r8[0], r9[0], r10[0]);
});

function createMainMap(layer01MetaData, layer02MetaData, layer03MetaData, layer04MetaData, layer05MetaData, layer01Features, layer02Features,  layer03Features,  layer04Features,  layer05Features) {
	var activeLayersIDs = [],
		layerNameById = {}; //NGW layers IDs

	layerNameById[layer01MetaData.resource.id] = layer01MetaData.resource.display_name;
	layerNameById[layer02MetaData.resource.id] = layer02MetaData.resource.display_name;
	layerNameById[layer03MetaData.resource.id] = layer03MetaData.resource.display_name;
	layerNameById[layer04MetaData.resource.id] = layer04MetaData.resource.display_name;
	layerNameById[layer05MetaData.resource.id] = layer05MetaData.resource.display_name;

	var layer01Markers = [],
		layer02Markers = [],
		layer03Markers = [],
		layer04Markers = [],
		layer05Markers = [];

	addMarkers(layer01Features, layer01Markers, '/sites/all/themes/start/map/img/marker-4.png');
	addMarkers(layer02Features, layer02Markers, '/sites/all/themes/start/map/img/marker-1.png');
	addMarkers(layer03Features, layer03Markers, '/sites/all/themes/start/map/img/marker-2.png');
	addMarkers(layer04Features, layer04Markers, '/sites/all/themes/start/map/img/marker-3.png');
	addMarkers(layer05Features, layer05Markers, '/sites/all/themes/start/map/img/marker-5.png');

	function addMarkers(layerFeatures, layerMarkers, markerUrl) {
		var markerIcon = L.icon({
			iconUrl: markerUrl,
			iconSize: [25, 40],
			iconAnchor: [12.5, 40]
		});

		layerFeatures.forEach(function(el, index, array) {
			var point = L.latLng(el.fields.Y_centroid, el.fields.X_centroid),
				marker = L.marker(point, {clickable: true, icon: markerIcon}),
				popup = L.popup({maxWidth: 200})
								 .setContent(el.fields.name + '</br><a href="' + el.fields.linkToInfo + '" target="_blank" class="map-popup-link">Подробнее >></a>');
			el.latlng = [el.fields.Y_centroid, el.fields.X_centroid];
			marker.bindPopup(popup);
			marker.on('click', function() {
				mapHistory.addRecord(el);
			});
			layerMarkers.push(marker);
		});
	};

	var main = L.tileLayer(tilesUrl, {minZoom: 13, maxZoom: 17, attribution: attrib, tms: false}),
		mesta_zahoroneniya_rasstrelyannyh = L.tileLayer(layer01, {minZoom: 13, maxZoom: 17, attribution: attrib}),
		konclagerya_1920h = L.tileLayer(layer02, {minZoom: 13, maxZoom: 17, attribution: attrib}),
		mesta_massovyh_rasstrelov = L.tileLayer(layer03, {minZoom: 13, maxZoom: 17, attribution: attrib}),
		mesta_zaklyucheniya = L.tileLayer(layer04, {minZoom: 13, maxZoom: 17, attribution: attrib}),
		sharashki = L.tileLayer(layer05, {minZoom: 13, maxZoom: 17, attribution: attrib}),
		allPlacesLayers = { 'main': main,
							'mesta_zahoroneniya_rasstrelyannyh': mesta_zahoroneniya_rasstrelyannyh,
							'konclagerya_1920h': konclagerya_1920h,
							'mesta_massovyh_rasstrelov': mesta_massovyh_rasstrelov,
							'mesta_zaklyucheniya': mesta_zaklyucheniya,
							'sharashki': sharashki
						  },
		allMarkersLayers = {'mesta_zahoroneniya_rasstrelyannyh': L.layerGroup(layer01Markers),
							'konclagerya_1920h': L.layerGroup(layer02Markers),
							'mesta_massovyh_rasstrelov': L.layerGroup(layer03Markers),
							'mesta_zaklyucheniya': L.layerGroup(layer04Markers),
							'sharashki': L.layerGroup(layer05Markers)
						  },
		allLayersExtents = {'mesta_zahoroneniya_rasstrelyannyh': [[55.391, 37.075], [56.030, 38.188]],
							'konclagerya_1920h': [[55.711, 37.548], [55.854, 37.68]],
							'mesta_massovyh_rasstrelov': [[55.391, 37.075], [56.030, 38.188]],
							'mesta_zaklyucheniya': [[55.391, 37.075], [56.030, 38.188]],
							'sharashki': [[55.391, 37.075], [56.030, 38.188]]
						  },
		map = new L.Map('map', {
			layers: [main],
			center: [55.7610, 37.6283],
			zoom: 14,
			fullscreenControl: true
		}),
		hash = new L.Hash(map, allPlacesLayers);

	// `fullscreenchange` Event that's fired when entering or exiting fullscreen.
	map.on('fullscreenchange', function () {
	    if (map.isFullscreen()) {
	        //console.log('entered fullscreen');
	    } else {
	        //console.log('exited fullscreen');
	    }
	});

	//Layers control
	var checkboxes = d3.selectAll('form#layersControl input[type="checkbox"]');
	//Initialize active layers
	checkboxes.each(function() {
		if (this.checked) {
			activeLayersIDs.push(this.value);
		};
	});
	//Add/remove layers on checkbox change
	checkboxes.on("change", function() {
		if (this.checked) {
			//Add buildings layer
			map.addLayer(allPlacesLayers[this.name]);
			activeLayersIDs.push(this.value);
			//Add markers layer
			if (map.getZoom() < 15) { (allMarkersLayers[this.name]).addTo(map); }
			//map.fitBounds(allLayersExtents[this.name]);
			map.setView([55.7610, 37.6283], 13);
		} else if (!this.checked && map.hasLayer(allPlacesLayers[this.name])) {
			//Remove buildings layer
			map.removeLayer(allPlacesLayers[this.name]);
			var index = activeLayersIDs.indexOf(this.value);
			if (index > -1) { activeLayersIDs.splice(index, 1); };
			//Remove markers layer
			map.removeLayer(allMarkersLayers[this.name]);
		};
		//console.log(this.name + ' checked: ' + this.checked + ' activeLayers: ' + activeLayersIDs);
	});

	//Change checkbox on layer add/remove
	map.on("layeradd layerremove", function(layer) {
		var checkboxes = d3.selectAll("#layersControl input");
		checkboxes.each(function() {
			var layer = allPlacesLayers[this.name],
				that = this;
			if (map.hasLayer(layer)) {
				that.checked = true;
			} else {
				that.checked = false;
			}
		});
	});

	map.on("zoomend", function() {
		var zoom = map.getZoom();
		if (zoom > 15) {
			$.each( allMarkersLayers, function( key, value ) {
				map.removeLayer(value);
			});
		} else {
			activeLayersIDs.forEach(function(el, ind, arr) {
				var layerName = layerNameById[el],
					markersLayer = allMarkersLayers[layerName];
				if (!map.hasLayer(markersLayer)) {
					map.addLayer(markersLayer);
				};
			})
		}
	})

	//Add history control
	var mapHistory = L.control.history({ displayHistory: true }).addTo(map);

	map.on('click', onMapClick);
	map.on('zoomstart', closePopupOnZoom);

	function closePopupOnZoom(e) {
		//console.log('zoomStart');
		this.closePopup();
	};

	function onMapClick(e) {
		//ReProject degrees to meters
		var coords = L.CRS.EPSG3857
			.project(e.latlng);
		//ID для активного векторного слоя, не для стиля!
		//console.log('activeLayers: ' + activeLayersIDs);
		var srs = 3857, geom = calculateHitArea(e.latlng, 10);

		//Resolve cross-domain issue
		var req = JSON.stringify({"srs":srs,"geom":geom,"layers":activeLayersIDs});

		$.post(urlIdentify, req, function(data) {
			//console.log(data); console.log(identificationRespHandler(data));
			var resp = identificationRespHandler(data);
			if (resp) {
				//resp.latlng = e.latlng;
				resp.latlng = [resp.fields.Y_centroid, resp.fields.X_centroid];
				resp.zoom = map.getZoom();
				$.get((urlLayers + resp.layerId), function(data) {
					resp.layerName = data.resource.display_name;
				});
				//resp.layerName = getLayerNameById(resp.layerId);
				//console.log(resp);
				openPopup(resp.latlng, resp.fields.name + '</br><a href="' + resp.fields.linkToInfo + '" target="_blank" class="map-popup-link">Подробнее >></a>');
				mapHistory.addRecord(resp);
			};
		}, "json");
	};

	function openPopup(latlng, msg) {
		var popup = L.popup({maxWidth: 200})
			.setLatLng(latlng)
			.setContent(msg)
			.openOn(map);
	};

	function identificationRespHandler(resp) {
		//No objects in hitArea
		if (resp.featureCount == 0) { return false; };
		//Objects found in hitArea
		for (var property in resp) {
			if (resp.hasOwnProperty(property) && property !== 'featureCount') {
				//console.log(property);
				if (resp[property].featureCount > 0) {
					var objData = resp[property].features[0];
					return objData;
				} else continue;
			};
	    };
	};

	function composeRequestData(srs, geom, layers) {
		var requestDataObj =
		{"srs":srs,"geom":geom,"layers":layers};
	}

	function calculateHitArea(latlng, radius) {
		//ReProject degrees to meters
		var coords = L.CRS.EPSG3857.project(latlng),
			NW = (coords.x - radius) + ' ' + (coords.y + radius),
			NE = (coords.x + radius) + ' ' + (coords.y + radius),
			SE = (coords.x + radius) + ' ' + (coords.y - radius),
			SW = (coords.x - radius) + ' ' + (coords.y - radius),
			hitPolygon = [NW, NE, SE, SW, NW];
		return "POLYGON((" + hitPolygon.toString() + "))";
	};

}