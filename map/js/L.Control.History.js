L.Control.HistoryControl = L.Control.extend({
	options: {
		position: 'topright',
		header: 'История посещений',
		displayHistory: true,
		viewedObjectsList: [],
		capacity: 5,
		width: 208,
		height: 163
	},

	hideText: 'Hide History',
	showText: 'Show History',

	initialize: function (options) {
		L.Util.setOptions(this, options);
	},

	onAdd: function (map) {
        // create the control container with a particular class name
        //var container = L.DomUtil.create('div', 'mapHistory-control');
        this._mainMap = map;
		//Creating the container and stopping events from spilling through to the main map.
		this._container = L.DomUtil.create('div', 'leaflet-control-history');
		this._container.style.width = this.options.width + 'px';
		this._container.style.height = this.options.height + 'px';
		//Turn off clicking through control
		L.DomEvent.disableClickPropagation(this._container);
		//L.DomEvent.on(this._container, 'mousewheel', L.DomEvent.stopPropagation);
		this._containerHeader = L.DomUtil.create('header', 'history-header', this._container);
		this._containerHeader.innerHTML = this.options.header;
		this._containerHistory = L.DomUtil.create('div', 'history-container', this._container);
		this._containerHistory.style.height = (this.options.height - 30) + 'px';
		this._containerListElem = L.DomUtil.create('ul', 'history-list', this._containerHistory);

		//Keep a record of this to prevent auto toggling when the user explicitly doesn't want it.
		this._userToggledDisplay = false;
		this._minimized = false;

		//Add fold/unfold button
		if (this.options.displayHistory) {
			this._addToggleButton();
		};

		this.setHistory(this.options.viewedObjectsList);

        return this._container;
    },

	addTo: function (map) {
		L.Control.prototype.addTo.call(this, map);
		//this._miniMap.setView(this._mainMap.getCenter(), this._decideZoom(true));
		this._setDisplay(true);
		return this;
	},

    setContent: function (content) {
    	this._container.innerHTML = content;
    	return this;
    },

    setHistory: function (history) {
    	this.options.viewedObjectsList = history.slice(0, this.options.capacity);
    	//this._container.innerHTML = '';
    	this._viewedObjectsListing();
    	return this;
    },

	addRecord: function (record) {
		//var viewedObjects = (typeof viewedObjects === "undefined") ? this.options.viewedObjectsList : viewedObjects;
		var viewedObjects = this.options.viewedObjectsList;
		if (viewedObjects.length < this.options.capacity) {
			viewedObjects.unshift(record);
		} else {
			viewedObjects.pop();
			viewedObjects.unshift(record);
		};
		this._viewedObjectsListing();
	},

    /*_viewedObjectsListing: function () {
    	var list = this._containerListElem,
    		records = list.getElementsByTagName('li');
    	//Remove all old stuff!
    	//records.delete();
        //Iterate through array and create list
        var viewedObjectsList = this.options.viewedObjectsList;
        //Check if it's not empty array
        if (typeof viewedObjectsList != "undefined" && viewedObjectsList != null && viewedObjectsList.length > 0) {
        	viewedObjectsList.forEach(function(element, index, array) {
        		var record = L.DomUtil.create('li', 'history-list-elem', list);
        		if (typeof element === 'object' && element !== null) {
        			record.innerHTML = element.fields.name;
        		} else {
        			record.innerHTML = element;
        		};
        	});
        };
    },*/

    _viewedObjectsListing: function () {
    	var map = this._mainMap,
    		list = d3.select(this._containerListElem),
    		viewedObjectsList = this.options.viewedObjectsList;
    	//Remove old stuff
    	list.selectAll('li').remove();
    	var records = list.selectAll('li')
    		.data(viewedObjectsList)
    		.enter()
    		.append('li')
    		.html(function(d) { return d.fields.name; })
    		.attr('class', 'history-list-elem')
    		.on('click', function(d) {
    			map.setView(d.latlng, d.zoom);
    			L.popup({maxWidth: 200})
				 .setLatLng(d.latlng)
				 .setContent(d.fields.name + '</br><a href="' + d.fields.linkToInfo + '" target="_blank" class="map-popup-link">Подробнее >></a>')
				 .openOn(map);
    		});
    },

	_addToggleButton: function () {
		this._toggleDisplayButton = this.options.displayHistory ? this._createButton(
		'', this.hideText, 'leaflet-control-history-toggle-display', this._container, this._toggleDisplayButtonClicked, this) : undefined;
	},

	_createButton: function (html, title, className, container, fn, context) {
		var link = L.DomUtil.create('a', className, container);
		link.innerHTML = html;
		link.href = '#';
		link.title = title;
		var stop = L.DomEvent.stopPropagation;
		//.on could be depricated (use .addListener instead)
		L.DomEvent
		.on(link, 'click', stop)
		.on(link, 'mousedown', stop)
		.on(link, 'dblclick', stop)
		.on(link, 'click', L.DomEvent.preventDefault)
		.on(link, 'click', fn, context);
		return link;
	},

	_toggleDisplayButtonClicked: function () {
		this._userToggledDisplay = true;
		if (!this._minimized) {
			this._minimize();
			this._toggleDisplayButton.title = this.showText;
		}
		else {
			this._restore();
			this._toggleDisplayButton.title = this.hideText;
		}
	},

	_setDisplay: function (minimize) {
		if (minimize != this._minimized) {
			if (!this._minimized) {
				this._minimize();
			} else {
				this._restore();
			}
		};
	},

	_minimize: function () {
		// hide the minimap
		if (this.options.displayHistory) {
			this._container.style.width = '208px';
			this._container.style.height = '28px';
			this._containerHeader.style.padding = '7px 0 0 28px';
			// this._container.style.padding = '12px 0 0px 0';
			//this._toggleDisplayButton.className = ' minn'
			//this._toggleDisplayButton.className += ' minimized';
			L.DomUtil.addClass(this._toggleDisplayButton, 'minimized');
			L.DomUtil.addClass(this._containerListElem, 'minimized');
		}
		else {
			this._container.style.display = 'block';
		}
		this._minimized = true;
	},

	_restore: function () {
		if (this.options.displayHistory) {
			this._container.style.width = this.options.width + 'px';
			this._container.style.height = this.options.height + 'px';
			this._containerHeader.style.padding = '20px 0 0 28px';
			//Remove .minimized from class
			this._toggleDisplayButton.className = this._toggleDisplayButton.className
			.replace(/(?:^|\s)minimized(?!\S)/g, '');
			L.DomUtil.removeClass(this._containerListElem, 'minimized');
		} else {
			this._container.style.display = 'none';
		}
		this._minimized = false;
	}
});

L.control.history = function (options) {
	return new L.Control.HistoryControl(options);
};