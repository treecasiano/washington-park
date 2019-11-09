<template>
  <div>
    <v-dialog v-model="dialog" scrollable max-width="600px">
      <template v-slot:activator="{ on }">
        <v-layout column class="searchInstructions">
          <h2 class="primary--text mb-2">Combat Invasive Species!</h2>
          <p>If you see an invasive species while you are in the park, please submit a quick report.</p>
          <div class="d-flex justify-center">
            <v-btn rounded outlined class="font-weight-bold" color="primary" dark v-on="on">
              <v-icon>note_add</v-icon>&nbsp;Submit Report
            </v-btn>
          </div>
          <v-list class="mt-5">
            <v-list-item-title>
              <h3>For more information:</h3>
            </v-list-item-title>
            <v-list-item>
              <v-list-item-content>
                <a href="https://www.portlandoregon.gov/bes/55085">Invasive Animals</a>
              </v-list-item-content>
            </v-list-item>
            <v-list-item>
              <v-list-item-content>
                <a href="https://www.portlandoregon.gov/parks/article/200906">Invasive Plants</a>
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </v-layout>
      </template>
      <v-form v-model="valid" style="z-index: 100000;" ref="form">
        <v-card class="elevation-0 pb-6 text-left">
          <v-container>
            <div
              class="text-left primary--text font-weight-bold"
            >Observation date, organism type, organism description, and location details are required.</div>
            <div>This application uses geolocation, so be sure you are in the vicinity of the invasive species.</div>
            <v-select
              :items="organismTypes"
              :rules="fieldRules"
              dense
              label="Organism Type"
              required
              v-model="record.organism_type"
            ></v-select>
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
              :rules="fieldRules"
              clearable
              counter="250"
              label="Location Details"
              required
              rows="1"
              v-model="record.location_details"
            ></v-textarea>
            <div class="primary--text font-weight-bold">To be added to our mailing list (optional):</div>
            <v-text-field dense label="Your Email" v-model="record.observer_email" required></v-text-field>
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
        this.record.geom = `POINT(${this.userLongitude} ${this.userLatitude})`;
        const now = new Date();
        const month = now.getMonth();
        const year = now.getFullYear();
        const day = now.getDate();
        this.record.observation_date = `${year}-${month + 1}-${day}`;
        await this.createRecord();
        await this.fetchGeoJSON();

        this.dialog = false;
        this.closeMapControls();
        this.notifySuccess();
        this.setCenter([this.userLatitude, this.userLongitude]);
        this.setZoom(18);
      } catch (e) {
        this.notifyFailure();
        // eslint-disable-next-line
        console.error(e);
      }
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
      // fake latitude for demo1: 45.518753
      // fake longitude for demo1: -122.705351
      // fake latitude for demo2: 45.516447
      // fake longitude for demo2: -122.715854
      const coordinates = {
        // latitude: position.coords.latitude,
        // longitude: position.coords.longitude,
        latitude: 45.516447,
        longitude: -122.715854,
      };
      this.setUserCoordinates(coordinates);
      this.showUserLatLng = true;
    },
    ...mapActions({
      createRecord: "invasiveSpeciesReport/create",
      fetchGeoJSON: "invasiveSpeciesReport/getGeoJSON",
    }),
    ...mapMutations({
      clearRecord: "invasiveSpeciesReport/clearRecord",
      setRecord: "invasiveSpeciesReport/setRecord",
      setCenter: "map/setCenter",
      setUserCoordinates: "map/setUserCoordinates",
      setZoom: "map/setZoom",
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
  watch: {
    dialog() {
      this.$refs.form.reset();
    },
  },
};
</script>

