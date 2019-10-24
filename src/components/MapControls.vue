<template>
  <v-card>
    <v-navigation-drawer v-model="drawer" :mini-variant.sync="mini" permanent>
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
          <v-layout column>
            <v-btn small color="primary" dark @click="showUserLocation">Show My Location!</v-btn>
            <div v-if="displayUserLocation">
              <div class="text-left">User Longitude: {{userLongitude.toFixed(4)}}</div>
              <div class="text-left">User Latitude: {{userLatitude.toFixed(4)}}</div>
            </div>
          </v-layout>
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
</style>
