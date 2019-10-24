<template>
  <v-container fluid>
    <h1 class="pl-2 font-weight-thin primary--text">Admin Console</h1>
    <v-layout row wrap>
      <v-flex xs12 pa-2>
        <v-tabs
          v-model="tab"
          @change="(object) => this.$router.push({ name: 'adminObject', params: { object } })"
        >
          <v-tab href="#parkLocation" ripple>Park Locations</v-tab>

          <v-tab-item key="1" value="parkLocation">
            <tab-park-location
              :mode="$route.params.mode"
              object="parkLocation"
              @success="notifySuccess"
              @failure="notifyFailure"
            ></tab-park-location>
          </v-tab-item>
        </v-tabs>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import TabParkLocation from "./TabParkLocation";

export default {
  components: {
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
