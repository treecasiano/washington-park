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
        :options="{zoomControl: false}"
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
        <div v-if="userLatitude && displayUserLocation">
          <l-marker :lat-lng="userMarker" :icon="userIcon">
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
            v-for="(item, index) in markersArrayParkLocation"
            v-bind:item="item"
            v-bind:index="index"
            v-bind:key="index"
            :lat-lng="item"
            :icon="item.icon"
          >
            <l-popup>
              <div>
                <strong>Location:&nbsp;</strong>
                {{item.props.location_name}}
              </div>
              <div>
                <strong>Address:&nbsp;</strong>
                {{item.props.street_addr_1}},
                <span
                  v-if="item.props.street_addr_2"
                >{{item.props.street_addr_2}},</span>
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
              <div>
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
              <div>
                <strong>Trail Name:</strong>
                {{item.props.trailname}}
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

const baseMapUrl =
  "https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png";
const attribution =
  '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>';

const defaultCenter = [45.5155, -122.715];
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
      displayTrails: state => state.trail.displayStatus,
      displayTransitStops: state => state.transitStop.displayStatus,
      displayUserLocation: state => state.map.displayStatus,
      parkLocationDataLoading: state => state.parkLocation.loading,
      parkLocationGeoJSON: state => state.parkLocation.geoJSON,
      invasiveSpeciesReportGeoJSON: state =>
        state.invasiveSpeciesReport.geoJSON,
      invasiveSpeciesReportsLoading: state =>
        state.invasiveSpeciesReport.loading,
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
    // TODO: Implement Promise.all
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
      loading: false,
      markersArrayInvasiveSpeciesReport: [],
      markersArrayParkLocation: [],
      markersArrayTransitStop: [],
      maxZoom: 18,
      minZoom: 4,
      parkBoundaries,
      polylineArrayTrails: [],
      subdomains: "abcd",
      url: baseMapUrl,
      // eslint-disable-next-line
      attractionIcon: L.icon({
        iconUrl: "leaflet/map_marker_attraction.svg",
        iconSize: [34, 34],
        iconAnchor: [17, 17],
        popupAnchor: [25, -40],
      }),
      // eslint-disable-next-line
      gardenIcon: L.icon({
        iconUrl: "leaflet/map_marker_garden.svg",
        iconSize: [34, 34],
        iconAnchor: [17, 17],
        popupAnchor: [25, -40],
      }),
      // eslint-disable-next-line
      genericIcon: L.icon({
        iconUrl: "leaflet/map_marker_generic.svg",
        iconSize: [34, 34],
        iconAnchor: [17, 17],
        popupAnchor: [25, -40],
      }),
      // eslint-disable-next-line
      picnicShelterIcon: L.icon({
        iconUrl: "leaflet/map_marker_picnic.svg",
        iconSize: [34, 34],
        iconAnchor: [17, 17],
        popupAnchor: [25, -40],
      }),
      // eslint-disable-next-line
      recreationFacilityIcon: L.icon({
        iconUrl: "leaflet/map_marker_rec.svg",
        iconSize: [34, 34],
        iconAnchor: [17, 17],
        popupAnchor: [25, -40],
      }),
      // eslint-disable-next-line
      transitStopIcon: L.icon({
        iconUrl: "leaflet/map_marker_transit.svg",
        iconSize: [34, 34],
        iconAnchor: [17, 17],
        popupAnchor: [25, -40],
      }),
      // eslint-disable-next-line
      userIcon: L.icon({
        iconUrl: "leaflet/map_marker_star.svg",
        iconSize: [34, 34],
        iconAnchor: [17, 17],
        popupAnchor: [25, -40],
      }),
      // eslint-disable-next-line
      userReportIcon: L.icon({
        iconUrl: "leaflet/map_marker_bug.svg",
        iconSize: [34, 34],
        iconAnchor: [17, 17],
        popupAnchor: [25, -40],
      }),
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
            icon = this.attractionIcon;
          }
          if (props.location_type === "picnic shelter") {
            icon = this.picnicShelterIcon;
          }
          if (props.location_type === "recreation facility") {
            icon = this.recreationFacilityIcon;
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
            weight: 2,
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
        this.userReportIcon
      );
    },
    createParkLocationMarkers(geoJSON) {
      this.markersArrayParkLocation = this.createMarkers(
        geoJSON,
        this.attractionIcon
      );
    },
    createTrailsPolyLines(geoJSON) {
      this.polylineArrayTrails = this.createPolyLines(geoJSON);
    },
    createTransitStopMarkers(geoJSON) {
      this.markersArrayTransitStop = this.createMarkers(
        geoJSON,
        this.transitStopIcon
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
        weight: 2,
        color: "#236557",
        opacity: 1,
        fillColor: "transparent",
      };
      const highlightStyle = {
        weight: 2,
        color: "#236557",
        opacity: 0.8,
        fillColor: "#dce775",
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
      setZoom: "map/setZoom",
    }),
  },
  mounted() {
    this.$nextTick(() => {});
  },
  props: {
    height: String,
    offsetHeight: String,
    width: String,
  },
};
</script>

<style>
.leaflet-container {
  font-family: "Kreon", sans-serif !important;
  font-size: 0.98rem;
}
</style>







