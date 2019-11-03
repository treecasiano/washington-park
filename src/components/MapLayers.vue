<template>
  <v-card>
    <v-navigation-drawer
      v-model="drawer"
      :mini-variant.sync="mini"
      permanent
      class="navDrawer--layers"
    >
      <template v-slot:prepend>
        <div v-if="mini">
          <v-btn icon @click.stop="mini = !mini">
            <v-icon color="primary">mdi-layers</v-icon>
          </v-btn>
        </div>
        <v-list-item v-if="!mini" dense>
          <v-spacer></v-spacer>
          <v-btn small icon @click.stop="mini = !mini">
            <v-icon color="primary">mdi-close</v-icon>
          </v-btn>
        </v-list-item>
        <v-container v-if="!mini" class="mapLayers">
          <v-layout>
            <v-flex class="mb-4">
              <div class="mapLayers__heading">
                <v-divider></v-divider>
                <div>Map Layers</div>
                <v-divider class="mb-4"></v-divider>
              </div>
              <v-checkbox
                :label="`Park Boundaries`"
                color="primary"
                data-cy="checkbox--parkBoundaries"
                v-model="displayStatusParkBoundaries"
              ></v-checkbox>
              <v-checkbox
                :label="`Trails`"
                color="primary"
                data-cy="checkbox--trails"
                v-if="trails.features"
                v-model="displayStatusTrails"
              ></v-checkbox>
              <v-checkbox
                :label="`Transit Stops`"
                color="primary"
                data-cy="checkbox--transitStops"
                v-if="transitStops.features"
                v-model="displayStatusTransitStops"
              ></v-checkbox>
              <v-checkbox
                :label="`Invasive Species Reports`"
                color="primary"
                data-cy="checkbox--invasiveSpeciesReports"
                v-if="invasiveSpeciesReports.features"
                v-model="displayStatusInvasiveSpeciesReports"
              ></v-checkbox>
              <div class="mapLayers__heading">
                <v-divider></v-divider>
                <div>Park Features</div>
                <v-divider class="mb-4"></v-divider>
              </div>
              <v-checkbox
                :label="`Attractions and Amenities`"
                color="primary"
                data-cy="checkbox--parkLocations"
                v-if="parkLocations.features"
                v-model="displayStatusParkLocations"
              ></v-checkbox>
              <div class="radioButtonGroup scrollBox">
                <v-radio-group
                  :disabled="!displayStatusParkLocations"
                  v-model="radiosParkLocationType"
                  class="pa-0"
                  style="margin: 0 0 -15px 32px;"
                  @change="filterParkLocations"
                >
                  <v-radio
                    color="accent"
                    label="All"
                    value="all"
                    class="layerControls--radioButtons"
                  ></v-radio>
                  <v-radio
                    color="accent"
                    label="Attraction"
                    value="attraction"
                    class="layerControls--radioButtons"
                  ></v-radio>
                  <v-radio
                    color="accent"
                    label="Bathroom"
                    value="bathroom"
                    class="layerControls--radioButtons"
                  ></v-radio>
                  <v-radio
                    color="accent"
                    label="Gardens"
                    value="garden"
                    class="layerControls--radioButtons"
                  ></v-radio>
                  <v-radio
                    color="accent"
                    label="Picnic Shelter"
                    value="picnic shelter"
                    class="layerControls--radioButtons"
                  ></v-radio>
                  <v-radio
                    color="accent"
                    label="Playground"
                    value="playground"
                    class="layerControls--radioButtons"
                  ></v-radio>
                  <v-radio
                    color="accent"
                    label="Public Art"
                    value="public art"
                    class="layerControls--radioButtons"
                  ></v-radio>
                  <v-radio
                    color="accent"
                    label="Recreation Facility"
                    value="recreation facility"
                    class="layerControls--radioButtons"
                  ></v-radio>
                  <v-radio
                    color="accent"
                    label="Restaurant"
                    value="restaurant"
                    class="layerControls--radioButtons"
                  ></v-radio>
                  <v-radio
                    color="accent"
                    label="Store"
                    value="store"
                    class="layerControls--radioButtons"
                  ></v-radio>
                </v-radio-group>
              </div>
            </v-flex>
          </v-layout>
        </v-container>
      </template>
    </v-navigation-drawer>
  </v-card>
</template>

<script>
import { mapActions, mapMutations, mapState } from "vuex";

export default {
  name: "MapLayers",
  computed: {
    displayStatusInvasiveSpeciesReports: {
      get() {
        return this.$store.state.invasiveSpeciesReport.displayStatus;
      },
      set(value) {
        this.displayInvasiveSpeciesReports(value);
      },
    },
    displayStatusParkBoundaries: {
      get() {
        return this.$store.state.parkBoundaries.displayStatus;
      },
      set(value) {
        this.displayParkBoundaries(value);
      },
    },
    displayStatusParkLocations: {
      get() {
        return this.$store.state.parkLocation.displayStatus;
      },
      set(value) {
        this.displayParkLocations(value);
      },
    },
    displayStatusTrails: {
      get() {
        return this.$store.state.trail.displayStatus;
      },
      set(value) {
        this.displayTrails(value);
      },
    },
    displayStatusTransitStops: {
      get() {
        return this.$store.state.transitStop.displayStatus;
      },
      set(value) {
        this.displayTransitStops(value);
      },
    },
    ...mapState({
      invasiveSpeciesReports: state => state.invasiveSpeciesReport.geoJSON,
      parkLocations: state => state.parkLocation.geoJSON,
      searchResultsParkLocations: state => state.parkLocation.searchResults,
      transitStops: state => state.transitStop.geoJSON,
      trails: state => state.trail.geoJSON,
    }),
  },
  data() {
    return {
      drawer: true,
      mini: true,
      radiosParkLocationType: "all",
    };
  },
  methods: {
    async filterParkLocations(value) {
      if (value == "all") {
        await this.fetchParkLocations();
      } else {
        const params = { location_type: value };
        await this.fetchParkLocations(params);
      }
    },
    ...mapActions({
      fetchParkLocations: "parkLocation/getGeoJSON",
    }),
    ...mapMutations({
      displayInvasiveSpeciesReports: "invasiveSpeciesReport/setDisplayStatus",
      displayParkBoundaries: "parkBoundaries/setDisplayStatus",
      displayParkLocations: "parkLocation/setDisplayStatus",
      displayTrails: "trail/setDisplayStatus",
      displayTransitStops: "transitStop/setDisplayStatus",
    }),
  },
  watch: {
    searchResultsParkLocations: function() {
      if (this.searchResultsParkLocations.length) {
        this.fetchParkLocations();
        this.radiosParkLocationType = "all";
        this.displayStatusParkLocations = true;
      }
    },
  },
};
</script>

<style>
/* Vuetify override */

.v-input--checkbox {
  margin: 0 !important;
  padding: 0 !important;
}

.layerControls--radioButtons {
  height: 22px !important;
  padding: 0;
}

.mapLayers
  .v-input--selection-controls:not(.v-input--hide-details)
  .v-input__slot {
  margin: -0 !important;
}
</style>

