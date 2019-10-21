<template>
  <div>
    <v-layout>
      <l-map
        ref="map"
        :zoom="zoom"
        :center="center"
        :maxZoom="maxZoom"
        @update:zoom="zoomUpdated"
        @update:center="centerUpdated"
        @update:bounds="boundsUpdated"
        :options="{zoomControl: false}"
        v-bind:style="`height: calc(${height}vh - ${offsetHeight}px); width: ${width}%;`"
      >
        <l-control-scale position="bottomleft"></l-control-scale>
        <l-tile-layer :url="url" :attribution="attribution"></l-tile-layer>
        <div v-if="displayParkBoundaries">
          <l-geo-json
            :geojson="parkBoundaries"
            :options="optionsParkBoundaries"
            :options-style="stylesParkBoundaries"
          ></l-geo-json>
        </div>
        <div>
          <l-marker
            v-for="(item, index) in markersArray"
            v-bind:item="item"
            v-bind:index="index"
            v-bind:key="index"
            :lat-lng="item"
          >
            <l-popup>
              <div>
                <strong>name</strong>
                : {{item.props.first_name}} {{item.props.last_name}}
              </div>
              <div>
                <strong>favorite color:</strong>
                {{item.props.favorite_color}}
              </div>
            </l-popup>
          </l-marker>
        </div>
        <div v-if="displayParkLocations && markersArrayParkLocation.length">
          <l-marker
            v-for="(item, index) in markersArrayParkLocation"
            v-bind:item="item"
            v-bind:index="index"
            v-bind:key="index"
            :lat-lng="item"
          >
            <l-popup>
              <div>
                <strong>props</strong>
                : {{item.props}}
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
        <l-control position="topright">
          <v-btn dark color="primary" @click="resetMapView">
            <v-icon>home</v-icon>
          </v-btn>
        </l-control>
      </l-map>
    </v-layout>
  </div>
</template>

<script>
import { mapState } from "vuex";
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
  computed: {
    exampleGeoJSON() {
      return this.$store.state.example.exampleGeoJSON;
    },
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
    ...mapState({
      displayParkBoundaries: state => state.parkBoundaries.displayStatus,
      displayParkLocations: state => state.parkLocation.displayStatus,
      displayTrails: state => state.trail.displayStatus,
      displayTransitStops: state => state.transitStop.displayStatus,
      parkLocationDataLoading: state => state.parkLocation.loading,
      parkLocationGeoJSON: state => state.parkLocation.geoJSON,
      trailsGeoJSON: state => state.trail.geoJSON,
      trailsLoading: state => state.trail.loading,
      transitStopDataLoading: state => state.transitStop.loading,
      transitStopGeoJSON: state => state.transitStop.geoJSON,
    }),
  },
  async created() {
    // TODO: Remove example code
    await this.$store.dispatch("example/getExampleGeoJSON");
    await this.$store.dispatch("transitStop/getGeoJSON");
    await this.$store.dispatch("trail/getGeoJSON");
    await this.$store.dispatch("parkLocation/getGeoJSON");
    this.createExampleMarkers(this.exampleGeoJSON);
    this.createTransitStopMarkers(this.transitStopGeoJSON);
    this.createParkLocationMarkers(this.parkLocationGeoJSON);
    this.createTrailsPolyLines(this.trailsGeoJSON);
  },
  data() {
    return {
      attribution,
      bounds: null,
      center: defaultCenter,
      loading: false,
      markersArray: [],
      markersArrayParkLocation: [],
      markersArrayTransitStop: [],
      maxZoom: 18,
      parkBoundaries,
      polylineArrayTrails: [],
      subdomains: "abcd",
      url: baseMapUrl,
      zoom: defaultZoom,
    };
  },
  methods: {
    boundsUpdated(bounds) {
      this.bounds = bounds;
    },
    centerUpdated(center) {
      this.center = center;
    },
    createExampleMarkers(geoJSON) {
      this.markersArray = this.createMarkers(geoJSON);
    },
    createMarkers(geoJSON) {
      const markersArray = geoJSON["features"].map(feature => {
        // eslint-disable-next-line
        let markerObject = L.latLng(
          feature["geometry"]["coordinates"][1],
          feature["geometry"]["coordinates"][0]
        );
        let props = feature["properties"];

        Object.assign(markerObject, { props });
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
    createParkLocationMarkers(geoJSON) {
      this.markersArrayParkLocation = this.createMarkers(geoJSON);
    },
    createTrailsPolyLines(geoJSON) {
      this.polylineArrayTrails = this.createPolyLines(geoJSON);
    },
    createTransitStopMarkers(geoJSON) {
      this.markersArrayTransitStop = this.createMarkers(geoJSON);
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
      this.$refs.map.setCenter(defaultCenter);
      this.$refs.map.setZoom(defaultZoom);
    },
    zoomUpdated(zoom) {
      this.zoom = zoom;
    },
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

<style >
</style>






