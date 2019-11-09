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
                  This application will help you learn more about the park's attractions, amenities, public art, miles of trails, and many other features before or during your visit. For more information, visit the park's
                  <a
                    color="secondary"
                    href="http://explorewashingtonpark.org/"
                  >website</a>.
                </p>
                <p>Use the tabs above to access forms to help you locate yourself and nearby features within the park. You can even help us keep the park ecosystem healthy by filing an invasive species report.</p>
              </v-layout>
            </v-tab-item>
            <v-tab-item key="2" value="search">
              <v-layout column mt-2>
                <h2 class="primary--text mb-2">Find Locations Near You!</h2>
                <p>Click the Search button to locate yourself and nearby park locations.</p>
                <div class="d-flex justify-center align-center">
                  <v-text-field
                    label="Miles"
                    class="ml-3 mr-5"
                    min="0.01"
                    max="10"
                    prepend-icon="place"
                    type="number"
                    step=".01"
                    v-model="searchRadius"
                  ></v-text-field>
                  <v-btn
                    rounded
                    outlined
                    class="mr-5 font-weight-bold"
                    color="primary"
                    dark
                    @click="showUserLocation"
                  >Search</v-btn>
                </div>
                <v-select
                  v-model="selectedLocationType"
                  :items="locationTypes"
                  clearable
                  label="Filter Search Results"
                  item-color="secondary"
                  style="z-index: 100000;"
                ></v-select>
                <v-layout column justify-start v-if="searchResultsParkLocations">
                  <div
                    class="font-weight-bold primary--text"
                    v-if="showSearchResults"
                  >{{searchResultsParkLocations.length}} result(s)</div>
                  <div class="searchResults scrollBox">
                    <ul class="text-left" style="list-style-type: none;">
                      <li
                        class="font-weight-thin caption"
                        v-for="(item) in searchResultsParkLocations"
                        v-bind:item="item"
                        v-bind:key="item.gid"
                      >
                        {{item.location_name}}, {{(item.distance*0.62137119 /1000).toFixed(2)}}mi
                        <v-btn
                          icon
                          class="text-left"
                          color="primary"
                          @click.stop="centerOnPoint(item)"
                        >
                          <v-icon>near_me</v-icon>
                        </v-btn>
                      </li>
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
import { locationTypes } from "../dropdownValues.json";
import { mapActions, mapMutations, mapState } from "vuex";
import ReportForm from "@/components/ReportForm.vue";

export default {
  components: {
    ReportForm,
  },
  computed: {
    searchResultsParkLocations() {
      const results = this.$store.state.parkLocation.searchResults;

      if (this.selectedLocationType) {
        const filteredResults = results.filter(result => {
          return result.location_type === this.selectedLocationType;
        });
        return filteredResults;
      }

      return results;
    },
    ...mapState({
      displayUserLocation: state => state.map.displayStatus,
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
      locationTypes,
      mini: false,
      searchRadius: 0.25,
      selectedLocationType: null,
      showSearchResults: false,
      tab: null,
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
      // fake latitude for demo: 45.518753
      // fake longitude for demo: -122.705351
      const coordinates = {
        // latitude: position.coords.latitude,
        // longitude: position.coords.longitude,
        latitude: 45.518753,
        longitude: -122.705351,
      };
      this.setUserCoordinates(coordinates);
    },
    centerOnPoint(item) {
      const pointCoordinates = [item.latitude, item.longitude];
      this.setSearchResultMarkerId(item.gid);
      this.setCenter([item.latitude, item.longitude]);
      this.setSearchResultMarkerLatLng([item.latitude, item.longitude]);
      this.setDisplayStatusSearchResultMarker(true);
      this.setZoom(17);
      this.mini = true;
    },
    showUserLocation() {
      this.getLocation();
      this.setUserLocationDisplayStatus(true);
      this.setCenter([this.userLatitude, this.userLongitude]);
      if (this.searchRadius) {
        // fetch list of points near user
        const geom = `${this.userLongitude}, ${this.userLatitude}`;
        const distanceMiles = this.searchRadius;
        const distanceConvertedToMeters = distanceMiles * 1609.34;
        const distance = distanceConvertedToMeters;
        this.fetchLocationsNearUser({
          geom,
          distance,
        });
      }
      this.setZoom(18);
      this.showSearchResults = true;
    },
    ...mapActions({
      fetchLocationsNearUser: "parkLocation/search",
    }),
    ...mapMutations({
      setCenter: "map/setCenter",
      setUserCoordinates: "map/setUserCoordinates",
      setUserLocationDisplayStatus: "map/setDisplayStatus",
      setZoom: "map/setZoom",
      setDisplayStatusSearchResultMarker:
        "parkLocation/setDisplayStatusSearchResultMarker",
      setSearchResultMarkerLatLng: "parkLocation/setSearchResultMarkerLatLng",
      setSearchResultMarkerId: "parkLocation/setSearchResultMarkerId",
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
