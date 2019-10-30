<template>
  <v-card>
    <v-navigation-drawer v-model="drawer" :mini-variant.sync="mini" permanent width="320">
      <template v-slot:prepend>
        <v-list-item v-if="mini" dense>
          <v-btn icon @click.stop="mini = !mini">
            <v-icon color="primary">mdi-chevron-right</v-icon>
          </v-btn>
        </v-list-item>
        <v-list-item v-if="!mini" dense>
          <v-spacer></v-spacer>
          <v-btn small icon @click.stop="mini = !mini">
            <v-icon color="primary">mdi-chevron-left</v-icon>
          </v-btn>
        </v-list-item>
        <v-container v-if="!mini">
          <v-tabs v-model="tab" centered active-class="mapControls__tabs--active" height="30">
            <v-tab href="#welcome" ripple>
              <v-icon>eco</v-icon>
            </v-tab>
            <v-tab href="#search" ripple>
              <v-icon>search</v-icon>
            </v-tab>
            <v-tab href="#form" ripple>
              <v-icon>note_add</v-icon>
            </v-tab>
            <v-tab-item key="1" value="welcome">
              <v-layout column>
                <h2 class="primary--text mb-2">Welcome to Washington Park!</h2>
                <p>
                  This application will help you learn more about the park's miles of trails, beautiful gardens, the Hoyt Arboretum, and many other attractions before or during your visit. For more information, visit the park's
                  <a
                    color="secondary"
                    href="http://explorewashingtonpark.org/"
                  >website</a>.
                </p>
                <p>Use the tabs above to locate yourself within the park or search for park locations closest to you. You can even help us keep the park healthy by filing an invasive species report.</p>
              </v-layout>
            </v-tab-item>
            <v-tab-item key="2" value="search">
              <v-layout column mt-2>
                <h2 class="primary--text mb-2">Find Locations Near You!</h2>
                <p>Click the button below to locate yourself within the park. To see the points nearest you, use the input to select a search radius.</p>
                <div class="d-flex justify-center align-center">
                  <v-text-field
                    label="Distance in km"
                    class="ml-3 mr-5"
                    prepend-icon="place"
                    type="number"
                    step=".1"
                    v-model="searchRadius"
                  ></v-text-field>
                  <v-btn
                    rounded
                    class="mr-5"
                    color="primary"
                    dark
                    @click="showUserLocation"
                  >FIND ME!</v-btn>
                </div>
                <v-layout v-if="searchResultsParkLocations">
                  <div class="searchResults scrollBox">
                    <ul class="text-left">
                      <li
                        v-for="(item) in searchResultsParkLocations"
                        v-bind:item="item"
                        v-bind:key="item.gid"
                      >{{item.location_name}}, {{(item.distance/1000).toFixed(2)}}km</li>
                    </ul>
                  </div>
                </v-layout>
              </v-layout>
            </v-tab-item>
            <v-tab-item key="3" value="form">
              <v-layout mt-2>
                <report-form @closeMapControls="mini=true"></report-form>
              </v-layout>
            </v-tab-item>
          </v-tabs>
        </v-container>
      </template>
    </v-navigation-drawer>
  </v-card>
</template>
<script>
import { mapActions, mapMutations, mapState } from "vuex";
import ReportForm from "@/components/ReportForm.vue";

export default {
  components: {
    ReportForm,
  },
  computed: {
    ...mapState({
      displayUserLocation: state => state.map.displayStatus,
      searchResultsParkLocations: state => state.parkLocation.searchResults,
      userLatitude: state => state.map.userLatitude,
      userLongitude: state => state.map.userLongitude,
    }),
  },
  created() {
    this.getLocation();
  },
  data() {
    return {
      drawer: true,
      mini: false,
      tab: null,
      searchRadius: null,
    };
  },
  methods: {
    getLocation() {
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(this.setUserLocation);
      } else {
        // eslint-disable-next-line
        console.error("Geolocation is not supported by this browser.");
      }
    },
    setUserLocation(position) {
      // fake latitude for demo: 45.5145948
      // fake longitude for demo: -122.7104008
      const coordinates = {
        latitude: position.coords.latitude,
        longitude: position.coords.longitude,
        // latitude: 45.5145948,
        // longitude: -122.7104008,
      };
      this.setUserCoordinates(coordinates);
    },
    showUserLocation() {
      this.getLocation();
      this.setUserLocationDisplayStatus(true);
      this.setCenter([this.userLatitude, this.userLongitude]);
      if (this.searchRadius) {
        // fetch list of points near user
        const geom = `${this.userLongitude}, ${this.userLatitude}`;
        const distance = this.searchRadius * 1000;
        this.fetchLocationsNearUser({
          geom,
          distance,
        });
      }
      this.setZoom(18);
    },
    ...mapActions({
      fetchLocationsNearUser: "parkLocation/search",
    }),
    ...mapMutations({
      setCenter: "map/setCenter",
      setUserCoordinates: "map/setUserCoordinates",
      setUserLocationDisplayStatus: "map/setDisplayStatus",
      setZoom: "map/setZoom",
    }),
  },
};
</script>

<style>
.mapControls__heading {
  font-weight: bold;
}
.mapControls__tabs--active {
  background-color: var(--v-accent-lighten4);
}
.v-dialog__content {
  z-index: 1000000 !important;
}
</style>
