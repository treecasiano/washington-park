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
      </template>
    </v-navigation-drawer>
  </v-card>
</template>
<script>
import { mapMutations, mapState } from "vuex";

export default {
  computed: {},
  created() {
    console.log("is this thing on?");
  },
  data() {
    return {
      drawer: true,
      mini: false,
    };
  },
  methods: {},
};
</script>

<style>
.mapControls__heading,
.mapControls__results {
  font-weight: bold;
}
@media only screen and (max-width: 500px) {
  .checkbox--chart {
    display: none;
  }
}

@media only screen and (max-height: 400px) {
  .checkbox--chart {
    display: none;
  }
  .mapControls__results {
    display: none;
  }
  .mapControls__heading {
    display: none;
  }
}
</style>
