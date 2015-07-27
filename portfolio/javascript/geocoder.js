/*
 * Copyright (c) 2013 Bundesamt by Kartographie und Geodäsie.
 * See license.txt in the BKG WebMap distribution or repository for the
 * full text of the license.
 *
 * Author: Dirk Thalheim
 */

/**
 * @requires OpenLayers/BaseTypes/Class.js
 * @requires OpenLayers/BaseTypes/Element.js
 * @requires BKGWebMap/Util.js
 * @requires BKGWebMap/Control/Search.js
 * @requires BKGWebMap/Protocol/Geoindex.js
 * @requires BKGWebMap/Util/AutoSuggest.js
 */


/**
 *
 * Zusätzliche Events:
 * <ul>
 *     <li>error - Bei Fehlern in Geocodierung; zusätzliche Event-Property response</li>
 *     <li>locationupdate - Nach erfolgreicher Geocodierung; zusätzliche Event-Property response</li>
 *     <li>hoverfeature - Hervorheben eines Features</li>
 * </ul>
 * @classdesc Kontrollelement für Geocodierung
 *
 * @constructor BKGWebMap.Control.Geocoder
 * @param {object} options - Optionen für das Controlelement
 **/
BKGWebMap.Control.Geocoder = OpenLayers.Class(BKGWebMap.Control.Search, {

    /**
     * URL für Geocodierungsdienst
     * @memberOf BKGWebMap.Control.Geocoder
     * @type string
     */
    url: 'http://sg.geodatenzentrum.de/gdz_geoindex',

    /**
     * Protokoll für Interaktion mit Geocodierungsdienst
     * @memberOf BKGWebMap.Control.Geocoder
     * @type BKGWebMap.Protocol.Geoindex
     */
    protocol: null,

    /**
     * Speichert die aktuelle Anfrage.
     * @memberOf BKGWebMap.Control.Geocoder
     * @type BKGWebMap.Protocol.Geoindex.Response
     */
    response: null,

    /**
     * Beschränkung der Suche auf aktuellen Kartenausschnitt.
     * @memberOf BKGWebMap.Control.Geocoder
     * @type boolean
     */
    useMapExtend: false,

    /**
     * Liste an Views für die Ergebnisdarstellung.
     * @memberOf BKGWebMap.Control.Geocoder
     * @type Array
     */
    views: [],

    initialize: function(options) {
        options = options || {};
        options.url = options.url || this.url;
        options.protocol = options.protocol || new BKGWebMap.Protocol.Geoindex({url: options.url});

        BKGWebMap.Control.Search.prototype.initialize.apply(this, [options]);

        BKGWebMap.Util.each(
                this.views,
                OpenLayers.Function.bind( function(index, view) { this.registerViewEvents(view); }, this )
        );

    },

    setMap: function(map) {
        BKGWebMap.Control.Search.prototype.setMap.apply(this, arguments);

        // Projektion für Ortssuche setzen
        this.protocol.srsName = map.projection;

        // map den Views übergeben
        BKGWebMap.Util.each( this.views, OpenLayers.Function.bind(function(index, view) { view.setMap(this); }, map) );

        // Über Änderungen des Viewports informiert werden:
        this.updateViewPort();
        map.events.on({
            moveend: this.updateViewPort,
            scope: this
        });

    },

    draw: function(px) {
        var div = BKGWebMap.Control.Search.prototype.draw.apply(this);
        // Autocomplete-Funktionalität initialisieren
        if(this.protocol.canAutocomplete) {
            this.autocomplete = new BKGWebMap.Util.AutoSuggest(this.input, this.protocol, {events: this.inputEvents});
        }
        return div;
    },

    /**
     * Fügt eine View für die Ergebnisdarstellung dem Geocoder hinzu.
     * @memberOf BKGWebMap.Control.Geocoder
     * @param {BKGWebMap.Control.Geocoder.View} view - Die View für die ergebnisanzeige
     */
    addView: function(view) {
        this.views.push(view);
        this.registerViewEvents(view);
        if(this.map) view.setMap(this.map);
    },

    registerViewEvents: function(view) {
        view.setGeocoder(this);
        this.events.on({
            "startsearch": view.onStartSearch,
            "error": view.onError,
            "locationupdate": view.onLocationUpdate,
            "hoverfeature": view.onHoverFeature,
            scope: view
        });
    },

    /**
     * Startet die Geocodierung
     *
     * @memberOf BKGWebMap.Control.Geocoder
     */
    triggerSearch: function() {
        BKGWebMap.Control.Search.prototype.triggerSearch.apply(this);
        if(this.response) {
            this.protocol.abort(this.response);
            this.response = null;
        }
        OpenLayers.Element.addClass(this.searchButton, "active");

        // stoppe AutoSuggest
        if(this.autocomplete) {
          this.autocomplete.hideSuggestions();  // hide the suggestion when searching
          this.autocomplete.cancel();
        }

        this.response = this.protocol.geocode(this.getValue(), {callback: this.handleResult, scope: this});
    },

    /**
     * Verarbeitet die Antwort vom Geocodierungsdienst
     * @memberOf BKGWebMap.Control.Geocoder
     * @param {BKGWebMap.Protocol.Geoindex.Response} response
     */
    handleResult: function(response) {
        OpenLayers.Element.removeClass(this.searchButton, "active");
        this.response = null;

        if(response.code != BKGWebMap.Protocol.Geoindex.Response.SUCCESS) {
            this.events.triggerEvent("error", {response: response});
            return;
        }

        switch(response.requestType) {
            case 'geocode':
                this.events.triggerEvent("locationupdate", {response: response});
                break;
        }
    },

    hoverFeature: function(feature, hover) {
        this.events.triggerEvent("hoverfeature", {feature: feature, hover: hover});
    },

    /**
     * Wird vom moveend-Event der Karte getriggert und informiert über Änderung des Viewports
     * @memberOf BKGWebMap.Control.Geocoder
     */
    updateViewPort: function() {
        if(!this.useMapExtend) return;
        // Kartenausdehnung im Protokoll verwenden
        this.protocol.bounds = this.map.getExtent();
        // Suggest-Cache leeren
        this.protocol.clearCache();
        // Autosuggest zurücksetzen
        if(this.autocomplete) {
            this.autocomplete.clearSuggestions();
        }
    },

    CLASS_NAME: "BKGWebMap.Control.Geocoder"
});

/**
 * Factory-Funktion zur Generierung eines Geocoder Steuerelement. Standardmäßig wird dieser mit einem LayerView
 * generiert. Falls ein BKGWebMap.Control.SidePanel in der controls-Liste enthalten ist, wird zusätzlich ein
 * BKGWebMap.Control.Geocoder.ListView dem Geocoder hinzugefügt.
 *
 * @param {Array<OpenLayers.Control>} controls - Liste der Steuerelemente, in die die neue erzeugten Steuerelemente
 *                                               eingefügt werden sollen.
 * @param {object} config - Konfiguration für Steuerelement (s. Konstruktor BKGWebMap.Control.Geocoder).
 */
BKGWebMap.Control.FACTORIES['geocoder'] = function(controls, config) {
    if (!config) return;

    var geocoder = new BKGWebMap.Control.Geocoder(config);
    geocoder.addView(new BKGWebMap.Control.Geocoder.LayerView());

    var sidePanel = BKGWebMap.Util.grep(controls, function(c) {return c.CLASS_NAME === 'BKGWebMap.Control.SidePanel'});
    if (sidePanel.length > 0) {
        var resultsDiv = document.createElement('div');

        var resultsDivTitle = document.createElement('h3');
        resultsDivTitle.innerHTML = 'Suchergebnisse';

        sidePanel[0].content.appendChild(resultsDivTitle );
        OpenLayers.Element.addClass(resultsDiv, 'geocoderResults');
        sidePanel[0].content.appendChild(resultsDiv);
        geocoder.addView(new BKGWebMap.Control.Geocoder.ListView({div: resultsDiv}));
    }
    controls.push(geocoder);
};