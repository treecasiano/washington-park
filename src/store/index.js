import Vue from "vue";
import Vuex from "vuex";

import example from "./example";
import parkBoundaries from "./parkBoundaries";

Vue.use(Vuex);

const vuexStore = new Vuex.Store({
  modules: {
    example,
    parkBoundaries,
  },
});

if (window.Cypress) {
  window.__store__ = vuexStore;
}

export default vuexStore;
