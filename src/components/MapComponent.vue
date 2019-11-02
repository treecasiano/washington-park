<template>
  <div>
    <v-layout>
      <l-map
        ref="map"
        :zoom="zoom"
        :center="center"
        :maxZoom="maxZoom"
        :minZoom="minZoom"
        @update:zoom="zoomUpdated"
        @update:center="centerUpdated"
        @update:bounds="boundsUpdated"
        :options="{zoomControl: false, zoomDelta: 0.25, zoomSnap: 0.25}"
        v-bind:style="`height: calc(${height}vh - ${offsetHeight}px); width: ${width}%;`"
      >
        <l-control position="topleft">
          <v-btn light @click="resetMapView" style="width: 80px;">
            <v-icon color="primary">home</v-icon>
          </v-btn>
        </l-control>
        <l-control position="topleft">
          <MapControls />
        </l-control>
        <l-control-scale position="bottomleft"></l-control-scale>
        <l-control position="topright">
          <MapLayers />
        </l-control>
        <l-tile-layer :url="url" :attribution="attribution"></l-tile-layer>
        <div v-if="displaySearchResultMarker">
          <l-circle-marker
            :lat-lng="searchResultMarker"
            :radius="searchResultMarkerRadius"
            :color="searchResultMarkerColor"
            :fill-color="searchResultMarkerColor"
            :fill-opacity=".75"
            :weight="5"
            :opacity="1"
          ></l-circle-marker>
        </div>
        <div v-if="userLatitude && displayUserLocation">
          <l-marker :lat-lng="userMarker" :icon="icons.userIcon" ref="userMarker" focus="true">
            <l-popup>
              <div class="primary--text font-weight-bold title">YOU ARE HERE!</div>
              <div>latitude: {{userMarker.props.latitude}}</div>
              <div>longitude: {{userMarker.props.longitude}}</div>
            </l-popup>
          </l-marker>
        </div>
        <div v-if="displayParkBoundaries">
          <l-geo-json
            :geojson="parkBoundaries"
            :options="optionsParkBoundaries"
            :options-style="stylesParkBoundaries"
          ></l-geo-json>
        </div>
        <div v-if="displayParkLocations && markersArrayParkLocation.length">
          <l-marker
            :ref="`parkLocation${item.props.gid}`"
            v-for="(item, index) in markersArrayParkLocation"
            v-bind:item="item"
            v-bind:index="index"
            v-bind:key="index"
            :lat-lng="item"
            :icon="item.icon"
            :z-index-offset="9000"
          >
            <l-popup :ref="`parkLocationPopup${item.props.gid}`">
              <div>
                <strong>Location:&nbsp;</strong>
                {{item.props.location_name}}
              </div>
              <div v-if="item.props.street_addr_1">
                <strong>Address:&nbsp;</strong>
                <span v-if="item.props.street_addr_1">{{item.props.street_addr_1}},</span>
                <span v-if="item.props.street_addr_2">{{item.props.street_addr_2}},</span>
                {{item.props.city}}, {{item.props.state}} {{item.props.zip}}
              </div>
              <div>
                <strong>Type of Location:&nbsp;</strong>
                {{item.props.location_type}}
              </div>
              <div v-if="item.props.hrs_of_operation">
                <strong>Hours of Operation:&nbsp;</strong>
                {{item.props.hrs_of_operation}}
              </div>
              <div v-if="item.props.description">
                <strong>Description:&nbsp;</strong>
                {{item.props.description}}
              </div>
              <div v-if="item.props.url">
                <a :href="item.props.url" class="primary--text font-weight-bold">>>> Visit Website</a>
              </div>
            </l-popup>
          </l-marker>
        </div>
        <div v-if="displayInvasiveSpeciesReports && markersArrayInvasiveSpeciesReport.length">
          <l-marker
            v-for="(item, index) in markersArrayInvasiveSpeciesReport"
            v-bind:item="item"
            v-bind:index="index"
            v-bind:key="index"
            :lat-lng="item"
            :icon="item.icon"
          >
            <l-popup>
              <div>
                <strong>Observation Date:&nbsp;</strong>
                {{item.props.observation_date}}
              </div>
              <div>
                <strong>Organism Type:&nbsp;</strong>
                {{item.props.organism_type}}
              </div>
              <div>
                <strong>Organism Description:&nbsp;</strong>
                {{item.props.organism_description}}
              </div>
              <div v-if="item.props.location_details">
                <strong>Location Details:&nbsp;</strong>
                {{item.props.location_details}}
              </div>
              <div v-if="item.props.admin_notes">
                <strong>Notes from Park Administration:&nbsp;</strong>
                {{item.props.admin_notes}}
              </div>
            </l-popup>
          </l-marker>
        </div>
        <div v-if="displayTransitStops && markersArrayTransitStop.length">
          <l-marker
            v-for="(item, index) in markersArrayTransitStop"
            v-bind:item="item"
            v-bind:index="index"
            v-bind:key="index"
            :lat-lng="item"
            :icon="item.icon"
          >
            <l-popup>
              <div>
                <strong>Route</strong>
                : {{item.props.rte_desc}}
              </div>
              <div>
                <strong>Direction</strong>
                : {{item.props.dir_desc}}
              </div>
              <div>
                <strong>Location</strong>
                : {{item.props.location}}
              </div>
              <div>
                <a
                  class="primary--text font-weight-bold"
                  href="https://trimet.org/"
                >>>> Trimet Transit Tracker</a>
              </div>
            </l-popup>
          </l-marker>
        </div>
        <div v-if="displayTrails && polylineArrayTrails.length">
          <l-polyline
            v-for="(item, index) in polylineArrayTrails"
            v-bind:item="item"
            v-bind:index="index"
            v-bind:key="index"
            :lat-lngs="item.latlngs"
            :color="item.color"
            :weight="item.weight"
            :dash-array="item.dashArray"
          >
            <l-popup>
              <div v-if="item.props.trailname">
                <strong>Trail Name:</strong>
                {{item.props.trailname}}
              </div>
              <div v-if="item.props.systemname">
                <strong>Trail System Name:</strong>
                {{item.props.systemname}}
              </div>
              <div v-if="item.props.trlsurface">
                <strong>Trail Surface:</strong>
                {{item.props.trlsurface}}
              </div>
              <div v-if="item.props.accessible">
                <strong>Accessible:&nbsp;</strong>
                <span v-if="item.props.accessible === 'Not Evaluated'">Not evaluated</span>
                <span v-if="item.props.accessible === 'Accessible'">Yes</span>
                <span v-if="item.props.accessible === 'Not Accessible'">No</span>
              </div>
            </l-popup>
          </l-polyline>
        </div>
        <l-control-zoom position="bottomright"></l-control-zoom>
      </l-map>
    </v-layout>
  </div>
</template>

<script>
import { mapMutations, mapState } from "vuex";

import MapControls from "@/components/MapControls.vue";
import MapLayers from "@/components/MapLayers.vue";
import parkBoundaries from "../../public/parkBoundaries.json";
const iconAttributes = {
  iconSize: [40, 40],
  iconAnchor: [20, 20],
  popupAnchor: [0, -24],
};
let icons = {
  attractionIcon: L.icon(
    Object.assign({ iconUrl: "leaflet/map_marker_star.svg" }, iconAttributes)
  ),
  bathroomIcon: L.icon(
    Object.assign(
      { iconUrl: "leaflet/map_marker_bathroom.svg" },
      iconAttributes
    )
  ),
  gardenIcon: L.icon(
    Object.assign({ iconUrl: "leaflet/map_marker_garden.svg" }, iconAttributes)
  ),
  genericIcon: L.icon(
    Object.assign({ iconUrl: "leaflet/map_marker_generic.svg" }, iconAttributes)
  ),
  picnicShelterIcon: L.icon(
    Object.assign({ iconUrl: "leaflet/map_marker_picnic.svg" }, iconAttributes)
  ),
  playgroundIcon: L.icon(
    Object.assign(
      { iconUrl: "leaflet/map_marker_playground.svg" },
      iconAttributes
    )
  ),
  publicArtIcon: L.icon(
    Object.assign(
      { iconUrl: "leaflet/map_marker_public_art.svg" },
      iconAttributes
    )
  ),
  recreationFacilityIcon: L.icon(
    Object.assign({ iconUrl: "leaflet/map_marker_rec.svg" }, iconAttributes)
  ),
  restaurantIcon: L.icon(
    Object.assign(
      { iconUrl: "leaflet/map_marker_restaurant.svg" },
      iconAttributes
    )
  ),
  storeIcon: L.icon(
    Object.assign({ iconUrl: "leaflet/map_marker_store.svg" }, iconAttributes)
  ),
  transitStopIcon: L.icon(
    Object.assign({ iconUrl: "leaflet/map_marker_transit.svg" }, iconAttributes)
  ),
  userIcon: L.icon(
    Object.assign({ iconUrl: "leaflet/map_marker_star2.svg" }, iconAttributes)
  ),
  userReportIcon: L.icon(
    Object.assign({ iconUrl: "leaflet/map_marker_bug.svg" }, iconAttributes)
  ),
};

const baseMapUrl =
  "https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png";
const attribution =
  '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>';

const defaultCenter = [45.5151, -122.713];
const defaultZoom = 15;

const popupOptions = {
  permanent: false,
  sticky: true,
};

export default {
  name: "MapComponent",
  components: {
    MapControls,
    MapLayers,
  },
  computed: {
    optionsParkBoundaries() {
      return {
        onEachFeature: this.onEachParkBoundariesFeature,
      };
    },
    stylesParkBoundaries() {
      return () => {
        return {};
      };
    },
    searchResultMarker() {
      const lat = this.searchResultMarkerLatLng[0];
      const long = this.searchResultMarkerLatLng[1];
      // eslint-disable-next-line
      const markerObject = L.latLng(lat, long);
      const props = {
        latitude: lat,
        longitude: long,
      };
      Object.assign(markerObject, { props });
      return markerObject;
    },
    userMarker() {
      const userLat = this.$store.state.map.userLatitude;
      const userLong = this.$store.state.map.userLongitude;
      // eslint-disable-next-line
      const markerObject = L.latLng(userLat, userLong);
      const props = {
        latitude: userLat,
        longitude: userLong,
      };
      Object.assign(markerObject, { props });
      return markerObject;
    },
    ...mapState({
      center: state => state.map.center,
      displayInvasiveSpeciesReports: state =>
        state.invasiveSpeciesReport.displayStatus,
      displayParkBoundaries: state => state.parkBoundaries.displayStatus,
      displayParkLocations: state => state.parkLocation.displayStatus,
      displaySearchResultMarker: state =>
        state.parkLocation.displayStatusSearchResultMarker,
      displayTrails: state => state.trail.displayStatus,
      displayTransitStops: state => state.transitStop.displayStatus,
      displayUserLocation: state => state.map.displayStatus,
      parkLocationDataLoading: state => state.parkLocation.loading,
      parkLocationGeoJSON: state => state.parkLocation.geoJSON,
      invasiveSpeciesReportGeoJSON: state =>
        state.invasiveSpeciesReport.geoJSON,
      invasiveSpeciesReportsLoading: state =>
        state.invasiveSpeciesReport.loading,
      searchResultMarkerLatLng: state =>
        state.parkLocation.searchResultMarkerLatLng,
      searchResultMarkerId: state => state.parkLocation.searchResultMarkerId,
      trailsGeoJSON: state => state.trail.geoJSON,
      trailsLoading: state => state.trail.loading,
      transitStopDataLoading: state => state.transitStop.loading,
      transitStopGeoJSON: state => state.transitStop.geoJSON,
      userLatitude: state => state.map.userLatitude,
      userLongitude: state => state.map.userLongitude,
      zoom: state => state.map.zoom,
    }),
  },
  async created() {
    // TODO: Implement Promise.all and use mapActions
    await this.$store.dispatch("invasiveSpeciesReport/getGeoJSON");
    await this.$store.dispatch("transitStop/getGeoJSON");
    await this.$store.dispatch("trail/getGeoJSON");
    await this.$store.dispatch("parkLocation/getGeoJSON");
    this.createInvasiveSpeciesReportMarkers(this.invasiveSpeciesReportGeoJSON);
    this.createTransitStopMarkers(this.transitStopGeoJSON);
    this.createParkLocationMarkers(this.parkLocationGeoJSON);
    this.createTrailsPolyLines(this.trailsGeoJSON);
  },
  data() {
    return {
      attribution,
      bounds: null,
      icons,
      loading: false,
      markersArrayInvasiveSpeciesReport: [],
      markersArrayParkLocation: [],
      markersArrayTransitStop: [],
      maxZoom: 18,
      minZoom: 4,
      parkBoundaries,
      polylineArrayTrails: [],
      searchResultMarkerRadius: 30,
      searchResultMarkerColor: "orange",
      subdomains: "abcd",
      url: baseMapUrl,
    };
  },
  methods: {
    boundsUpdated(bounds) {
      this.bounds = bounds;
    },
    centerUpdated(center) {
      this.setCenter(center);
    },
    createMarkers(geoJSON, alternateIcon) {
      const markersArray = geoJSON["features"].map(feature => {
        // eslint-disable-next-line
        let markerObject = L.latLng(
          feature["geometry"]["coordinates"][1],
          feature["geometry"]["coordinates"][0]
        );
        let props = feature["properties"];

        Object.assign(markerObject, { props });
        if (alternateIcon) {
          let icon = alternateIcon;
          if (props.location_type === "attraction") {
            icon = this.icons.attractionIcon;
          }
          if (props.location_type === "bathroom") {
            icon = this.icons.bathroomIcon;
          }
          if (props.location_type === "garden") {
            icon = this.icons.gardenIcon;
          }
          if (props.location_type === "playground") {
            icon = this.icons.playgroundIcon;
          }
          if (props.location_type === "picnic shelter") {
            icon = this.icons.picnicShelterIcon;
          }
          if (props.location_type === "public art") {
            icon = this.icons.publicArtIcon;
          }
          if (props.location_type === "recreation facility") {
            icon = this.icons.recreationFacilityIcon;
          }
          if (props.location_type === "restaurant") {
            icon = this.icons.restaurantIcon;
          }
          if (props.location_type === "store") {
            icon = this.icons.storeIcon;
          }

          Object.assign(markerObject, { icon });
        }
        return markerObject;
      });
      return markersArray;
    },
    createPolyLines(geoJSON) {
      const polyLineArray = geoJSON["features"].map(feature => {
        // eslint-disable-next-line
        const coordinatesArray = feature["geometry"]["coordinates"][0];
        let polyLineObjectArray = coordinatesArray.map(coordinates => {
          // Leaflet requires the order to lat,long; geojson is formatted as long,lat
          return [coordinates[1], coordinates[0]];
        });
        let props = feature["properties"];
        const polyLineObj = Object.assign(
          {},
          {
            latlngs: polyLineObjectArray,
            props,
            color: "grey",
            dashArray: "4",
            weight: 3,
          }
        );
        return polyLineObj;
      });
      return polyLineArray;
    },
    createParkBoundariesContent(props) {
      let propertyString = `<strong>${props.NAME}</strong>`;
      return propertyString;
    },
    createInvasiveSpeciesReportMarkers(geoJSON) {
      this.markersArrayInvasiveSpeciesReport = this.createMarkers(
        geoJSON,
        this.icons.userReportIcon
      );
    },
    createParkLocationMarkers(geoJSON) {
      this.markersArrayParkLocation = this.createMarkers(
        geoJSON,
        this.icons.attractionIcon
      );
    },
    createTrailsPolyLines(geoJSON) {
      this.polylineArrayTrails = this.createPolyLines(geoJSON);
    },
    createTransitStopMarkers(geoJSON) {
      this.markersArrayTransitStop = this.createMarkers(
        geoJSON,
        this.icons.transitStopIcon
      );
    },
    onEachParkBoundariesFeature(feature, layer) {
      const popupContent = this.createParkBoundariesContent(feature.properties);
      this.setParkBoundariesStyles(layer, feature);
      layer.bindPopup(popupContent, popupOptions);
    },
    setBaseStyles(layer, defaultStyles, hightlightStyles) {
      layer.setStyle(defaultStyles);
      layer.on("mouseover", () => {
        layer.setStyle(hightlightStyles);
      });
      layer.on("mouseout", () => {
        layer.setStyle(defaultStyles);
      });
    },
    setParkBoundariesStyles(layer) {
      const defaultStyle = {
        weight: 3,
        color: "#236557",
        opacity: 0.9,
        fillColor: "#90f1fd",
        fillOpacity: 0.4,
      };
      const highlightStyle = {
        weight: 2,
        color: "#236557",
        opacity: 1,
        fillColor: "#FFE694",
        fillOpacity: 0.5,
      };
      this.setBaseStyles(layer, defaultStyle, highlightStyle);
    },
    resetMapView() {
      this.setCenter(defaultCenter);
      this.setZoom(defaultZoom);
    },
    zoomUpdated(zoom) {
      this.setZoom(zoom);
    },
    ...mapMutations({
      setCenter: "map/setCenter",
      setDisplayStatusSearchResultMarker:
        "parkLocation/setDisplayStatusSearchResultMarker",
      setZoom: "map/setZoom",
    }),
  },
  mounted() {
    this.$nextTick(() => {
      // this.$refs.map.mapObject.scrollWheelZoom.disable();
    });
  },
  props: {
    height: String,
    offsetHeight: String,
    width: String,
  },
  watch: {
    invasiveSpeciesReportGeoJSON: function() {
      this.$refs.map.mapObject.eachLayer(function(layer) {
        layer.closePopup();
      });
      this.createInvasiveSpeciesReportMarkers(
        this.invasiveSpeciesReportGeoJSON
      );
    },
    parkLocationGeoJSON: function() {
      this.createParkLocationMarkers(this.parkLocationGeoJSON);
    },
    searchResultMarkerLatLng: function() {
      // close all popups
      this.$refs.map.mapObject.eachLayer(function(layer) {
        layer.closePopup();
      });

      if (this.searchResultMarkerId) {
        // TODO: Trigger popup
        const refs = this.$refs;
        const [marker] = refs[`parkLocation${this.searchResultMarkerId}`];
        const [popup] = refs[`parkLocationPopup${this.searchResultMarkerId}`];
      }
    },
  },
};
</script>

<style>
.leaflet-container {
  font-family: "Kreon", sans-serif !important;
  font-size: 0.98rem;
}

.scrollBox {
  overflow: auto;
}

.radioButtonGroup.scrollBox {
  height: 165px;
  padding-top: 5px;
}

.searchResults.scrollBox {
  overflow: auto;
  max-height: 165px;
}

.mapLayers__heading {
  font-size: 16px;
  font-weight: bold;
  /* hiding headings on small screens by default */
  display: none;
  color: var(--v-primary-darken1);
  background: var(--v-accent-lighten4);
}

/* when screen height is taller than 700px */
@media only screen and (min-height: 700px) {
  .mapLayers__heading {
    display: block;
  }

  .radioButtonGroup.scrollBox {
    height: 350px;
  }

  .searchResults.scrollBox {
    max-height: 350px;
  }
}
</style>







