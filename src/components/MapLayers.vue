<template>
  <v-card>
    <v-navigation-drawer v-model="drawer" :mini-variant.sync="mini" permanent width="250">
      <template v-slot:prepend>
        <div v-if="mini">
          <v-btn icon @click.stop="mini = !mini">
            <v-icon>mdi-layers</v-icon>
          </v-btn>
        </div>
        <v-list-item v-if="!mini" dense>
          <v-spacer></v-spacer>
          <v-btn small icon @click.stop="mini = !mini">
            <v-icon>mdi-close</v-icon>
          </v-btn>
        </v-list-item>
        <v-container v-if="!mini" class="mapLayers">
          <v-layout>
            <v-flex class="mb-4">
              <div class="mapLayers__heading">
                <v-divider></v-divider>
                <div>Park Attractions and Amenities</div>
                <v-divider class="mb-4"></v-divider>
              </div>
              <v-checkbox
                :label="`Park Boundaries`"
                color="primary"
                data-cy="checkbox--parkBoundaries"
                v-model="displayStatusParkBoundaries"
              ></v-checkbox>
              <v-checkbox
                :label="`Park Attractions and Amenities`"
                color="primary"
                data-cy="checkbox--parkLocations"
                v-if="parkLocations.features"
                v-model="displayStatusParkLocations"
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
            </v-flex>
          </v-layout>
        </v-container>
      </template>
    </v-navigation-drawer>
  </v-card>
</template>

<script>
import { mapMutations, mapState } from "vuex";

export default {
  name: "MapLayers",
  computed: {
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
      parkLocations: state => state.parkLocation.geoJSON,
      transitStops: state => state.transitStop.geoJSON,
      trails: state => state.trail.geoJSON,
    }),
  },
  data() {
    return {
      drawer: true,
      mini: false,
    };
  },
  methods: {
    ...mapMutations({
      displayParkBoundaries: "parkBoundaries/setDisplayStatus",
      displayParkLocations: "parkLocation/setDisplayStatus",
      displayTrails: "trail/setDisplayStatus",
      displayTransitStops: "transitStop/setDisplayStatus",
    }),
  },
};
</script>

<style>
/* Vuetify override */

.mapLayers
  .v-input--selection-controls:not(.v-input--hide-details)
  .v-input__slot {
  margin: -0 !important;
}

.mapLayers__heading {
  font-weight: bold;
}
@media only screen and (max-height: 500px) {
  .mapLayers__heading {
    display: none;
  }
}
</style>

