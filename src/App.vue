<template>
  <v-app id="app" app>
    <div>
      <v-toolbar dense id="nav" dark color="primary">
        <v-toolbar-title>
          <a
            alt="Link to Home"
            href="/"
            class="white--text"
            style="text-decoration: none;"
          >Washington Park & Hoyt Arboretum</a>
        </v-toolbar-title>
      </v-toolbar>
    </div>
    <router-view />
  </v-app>
</template>

<script>
export default {
  async created() {},
  data: () => ({}),
};
</script>

<style>
@import url("https://fonts.googleapis.com/css?family=Kreon");
#app {
  font-family: "Kreon", sans-serif !important;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
}
</style>
