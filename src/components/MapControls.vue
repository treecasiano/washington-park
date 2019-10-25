<template>
  <v-card>
    <v-navigation-drawer v-model="drawer" :mini-variant.sync="mini" permanent width="400">
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
        <v-container v-if="!mini" style="height: 300px;">
          <v-tabs v-model="tab" centered active-class="mapControls__tabs--active">
            <v-tab href="#welcome" ripple>
              <v-icon>eco</v-icon>
            </v-tab>
            <v-tab href="#search" ripple>
              <v-icon>search</v-icon>
            </v-tab>
            <v-tab href="#form" ripple>
              <v-icon>bug_report</v-icon>
            </v-tab>
            <v-tab-item key="1" value="welcome">
              <v-layout mt-5>Welcome to Washington Park and Hoyt Arboretum</v-layout>
            </v-tab-item>
            <v-tab-item key="2" value="search">
              <v-layout column mt-5>
                <v-btn small color="primary" dark @click="showUserLocation">Show My Location!</v-btn>
                <div v-if="displayUserLocation">
                  <div class="text-left">User Longitude: {{userLongitude.toFixed(4)}}</div>
                  <div class="text-left">User Latitude: {{userLatitude.toFixed(4)}}</div>
                </div>
              </v-layout>
            </v-tab-item>
            <v-tab-item key="3" value="form">
              <v-layout mt-5>Form</v-layout>
            </v-tab-item>
          </v-tabs>
        </v-container>
      </template>
    </v-navigation-drawer>
  </v-card>
</template>
<script>
import { mapMutations, mapState } from "vuex";

export default {
  computed: {
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
      mini: false,
      tab: null,
    };
  },
  methods: {
    getLocation() {
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(this.setUserLocation);
      } else {
        console.log("Geolocation is not supported by this browser.");
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
    showUserLocation(position) {
      this.getLocation();
      this.setUserLocationDisplayStatus(true);
      this.setCenter([this.userLatitude, this.userLongitude]);
    },
    ...mapMutations({
      setCenter: "map/setCenter",
      setUserCoordinates: "map/setUserCoordinates",
      setUserLocationDisplayStatus: "map/setDisplayStatus",
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
</style>
