import Vue from "vue";
import Vuex from "vuex";

import invasiveSpeciesReport from "./invasiveSpeciesReport";
import parkBoundaries from "./parkBoundaries";
import parkLocation from "./parkLocation";
import trail from "./trail";
import transitStop from "./transitStop";
import map from "./map";

Vue.use(Vuex);

const vuexStore = new Vuex.Store({
  modules: {
    invasiveSpeciesReport,
    parkBoundaries,
    parkLocation,
    trail,
    transitStop,
    map,
  },
});

if (window.Cypress) {
  window.__store__ = vuexStore;
}

export default vuexStore;
