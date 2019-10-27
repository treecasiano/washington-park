<template>
  <div>
    <v-dialog v-model="dialog" scrollable max-width="600px">
      <template v-slot:activator="{ on }">
        <v-layout column>
          <h2 class="primary--text mb-2">Help us Combat Invasive Species!</h2>
          <p>If you see an invasive species while you are in the park, please submit a quick report. We will use the geolocation feature in your browser to get your current location and send the coordinates along with your report submission so we know exactly where you saw the organism.</p>
          <p>If you are not currently near the location where you spotted the invasive species or you do not have a geolocation service enabled, you will need to input the latitude and longitude manually.</p>
          <v-btn large rounded color="primary" dark v-on="on" class="ma-0">
            <v-icon>note_add</v-icon>&nbsp;Submit Report
          </v-btn>
        </v-layout>
      </template>
      <v-form v-model="valid" style="z-index: 100000; height: 800px;">
        <v-card class="elevation-0 pb-6">
          <v-container>
            <v-row>
              <v-col>
                <v-menu
                  ref="menu"
                  v-model="menu"
                  :close-on-content-click="false"
                  :return-value.sync="record.observation_date"
                  transition="scale-transition"
                  offset-y
                  min-width="290px"
                >
                  <template v-slot:activator="{ on }">
                    <v-text-field
                      :rules="fieldRules"
                      v-model="record.observation_date"
                      label="Observation Date"
                      prepend-icon="event"
                      readonly
                      v-on="on"
                      required
                    ></v-text-field>
                  </template>
                  <v-date-picker v-model="record.observation_date" no-title scrollable>
                    <v-spacer></v-spacer>
                    <v-btn text color="primary" @click="menu = false">Cancel</v-btn>
                    <v-btn text color="primary" @click="$refs.menu.save(record.observation_date)">OK</v-btn>
                  </v-date-picker>
                </v-menu>
              </v-col>
              <v-col>
                <v-select
                  :items="organismTypes"
                  :rules="fieldRules"
                  dense
                  label="Organism Type"
                  required
                  v-model="record.organism_type"
                ></v-select>
              </v-col>
            </v-row>
            <v-text-field dense label="Your Email" v-model="record.observer_email" required></v-text-field>
            <v-row>
              <v-col>
                <v-text-field
                  cols="6"
                  dense
                  label="Your First Name"
                  required
                  v-model="record.observer_first_name"
                ></v-text-field>
              </v-col>
              <v-col>
                <v-text-field
                  cols="6"
                  dense
                  label="Your Last Name"
                  required
                  v-model="record.observer_last_name"
                ></v-text-field>
              </v-col>
            </v-row>

            <v-textarea
              auto-grow
              :rules="fieldRules"
              clearable
              counter="250"
              label="Organism Description"
              required
              rows="1"
              v-model="record.organism_description"
            ></v-textarea>
            <v-textarea
              auto-grow
              clearable
              counter="250"
              label="Location Details"
              rows="1"
              v-model="record.location_details"
            ></v-textarea>
            <div class="text-left">We will use your current location unless you check the box below.</div>
            <div v-if="userLatitude && userLongitude" class="text-left">
              <span
                v-if="userLatitude && userLongitude"
              >Lat: {{userLatitude.toFixed(4)}}, Long: {{userLongitude.toFixed(4)}}</span>
            </div>
            <div v-else>Your location is unknown. Please enter coordinates below.</div>
            <v-checkbox v-model="useOtherLatLng" label="Use Other Coordinates"></v-checkbox>
            <div v-show="useOtherLatLng">
              <div
                class="text-left"
              >These coordinates will default to the center of the park. Please adjust them accordingly.</div>
              <div class="d-flex">
                <v-text-field label="Latitude:" v-model="otherLatitude" :rules="fieldRules"></v-text-field>
                <v-text-field label="Longitude:" v-model="otherLongitude" :rules="fieldRules"></v-text-field>
              </div>
            </div>
            <div
              v-show="!valid"
              class="text-left warning--text font-weight-bold caption"
            >Observation date, organism type, lat/long, and organism description are required.</div>
            <div class="d-flex justify-end mt-3">
              <v-btn class="mr-3" rounded outlined @click="cancel">Cancel</v-btn>
              <v-btn rounded color="primary" @click="create" :disabled="!valid">Submit</v-btn>
            </div>
          </v-container>
        </v-card>
      </v-form>
    </v-dialog>
  </div>
</template>

<script>
import { mapActions, mapMutations, mapState } from "vuex";

export default {
  computed: {
    ...mapState({
      record: state => state.invasiveSpeciesReport.record,
      userLatitude: state => state.map.userLatitude,
      userLongitude: state => state.map.userLongitude,
    }),
  },
  created() {
    this.getLocation();
  },
  data: () => ({
    dialog: false,
    fieldRules: [v => !!v || "Field is required"],
    menu: false,
    organismTypes: ["plant", "animal"],
    otherLatitude: 45.5155,
    otherLongitude: -122.715,
    useOtherLatLng: false,
    valid: false,
  }),
  methods: {
    cancel() {
      this.dialog = false;
      this.clearRecord();
    },
    closeMapControls() {
      this.$emit("closeMapControls");
    },

    async create() {
      try {
        if (this.useOtherLatLng) {
          this.record.geom = `POINT(${this.otherLongitude} ${this.otherLatitude})`;
        } else {
          this.record.geom = `POINT(${this.userLongitude} ${this.userLatitude})`;
        }
        await this.createRecord();
        this.dialog = false;
        this.closeMapControls();
        this.notifySuccess();
        this.setCenter([this.userLatitude, this.userLongitude]);
      } catch (e) {
        // eslint-disable-next-line
        this.notifyFailure();
        console.error(e);
      }
      await this.fetchList();
    },
    getLocation() {
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(this.setUserLocation);
      } else {
        // eslint-disable-next-line
        console.error("Geolocation is not supported by this browser.");
      }
    },
    notifyFailure() {
      this.failureNotification();
    },
    notifySuccess() {
      this.successNotification();
    },
    setUserLocation(position) {
      // fake latitude for demo: 45.5145948
      // fake longitude for demo: -122.7104008
      const coordinates = {
        // latitude: position.coords.latitude,
        // longitude: position.coords.longitude,
        latitude: 45.5145948,
        longitude: -122.7104008,
      };
      this.setUserCoordinates(coordinates);
      this.showUserLatLng = true;
    },
    ...mapActions({
      createRecord: "invasiveSpeciesReport/create",
      fetchList: "invasiveSpeciesReport/list",
    }),
    ...mapMutations({
      clearRecord: "invasiveSpeciesReport/clearRecord",
      setRecord: "invasiveSpeciesReport/setRecord",
      setCenter: "map/setCenter",
      setUserCoordinates: "map/setUserCoordinates",
    }),
  },
  notifications: {
    successNotification: {
      title: "Success!",
      message: "Thank you for submitting a report.",
      type: "success",
    },
    failureNotification: {
      title: "Submission failed!",
      message:
        "Please try again later or contact park administration for assistance.",
      type: "warn",
    },
  },
};
</script>

