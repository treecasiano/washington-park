import Vue from "vue";
import Vuex from "vuex";

import example from "./example";
import transitStop from "./transitStop";

Vue.use(Vuex);

const vuexStore = new Vuex.Store({
  modules: {
    example,
    transitStop,
  },
});

if (window.Cypress) {
  window.__store__ = vuexStore;
}

export default vuexStore;
