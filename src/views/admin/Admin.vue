<template>
  <v-container fluid>
    <h1 class="pl-2 font-weight-thin primary--text">
      <router-link
        alt="Link to Home"
        to="/admin/parkLocation"
        class="primary--text"
        style="text-decoration: none;"
      >Admin Console</router-link>
    </h1>
    <v-layout row wrap>
      <v-flex xs12 pa-2>
        <v-tabs
          v-model="tab"
          @change="(object) => this.$router.push({ name: 'adminObject', params: { object } })"
        >
          <v-tab href="#parkLocation" ripple>Park Locations</v-tab>
          <v-tab href="#invasiveSpeciesReport" ripple>Invasive Species Reports</v-tab>

          <v-tab-item key="1" value="parkLocation">
            <tab-park-location
              :mode="$route.params.mode"
              object="parkLocation"
              @success="notifySuccess"
              @failure="notifyFailure"
            ></tab-park-location>
          </v-tab-item>
          <v-tab-item key="2" value="invasiveSpeciesReport">
            <tab-invasive-species-report
              :mode="$route.params.mode"
              object="invasiveSpeciesReport"
              @success="notifySuccess"
              @failure="notifyFailure"
            ></tab-invasive-species-report>
          </v-tab-item>
        </v-tabs>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import TabInvasiveSpeciesReport from "./TabInvasiveSpeciesReport";
import TabParkLocation from "./TabParkLocation";

export default {
  components: {
    TabInvasiveSpeciesReport,
    TabParkLocation,
  },
  created() {
    this.tab = this.$route.params.object;
  },
  data() {
    return {
      tab: null,
    };
  },
  methods: {
    notifyFailure() {
      this.failureNotification();
    },
    notifySuccess() {
      this.successNotification();
    },
  },
  notifications: {
    successNotification: {
      title: "Succeeded",
      message: "",
      type: "success",
    },
    failureNotification: {
      title: "Failed",
      message: "",
      type: "warn",
    },
  },
};
</script>
