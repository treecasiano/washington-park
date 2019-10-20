<template>
  <v-app id="app" app>
    <div>
      <v-toolbar dense id="nav" dark color="primary">
        <v-toolbar-title>Washington Park</v-toolbar-title>
      </v-toolbar>
    </div>
    <router-view />
  </v-app>
</template>

<script>
export default {
  async created() {
    await this.$store.dispatch("transitStop/getGeoJSON");
    Promise.all([getTransitStopsPromise]);
  },
  data: () => ({}),
};
</script>

<style>
@import url("https://fonts.googleapis.com/css?family=Muli");
#app {
  font-family: "Muli", sans-serif !important;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
}

#nav a {
  font-weight: bold;
  color: var(--v-primary-base);
  display: block;
  padding: 10px;
}

#nav a.router-link-exact-active {
  color: var(--v-secondary-base);
}
</style>
