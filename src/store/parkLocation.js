import parkLocationApi from "../api/parkLocation";

const actions = {
  async displayData({ commit, status }) {
    return commit("setDisplayStatus", status);
  },
  async getList({ commit }) {
    commit("setLoadingStatus", true);
    const result = await parkLocationApi.list();
    commit("setLoadingStatus", false);
    return commit("setList", result.data);
  },
  async getGeoJSON({ commit }) {
    commit("setLoadingStatus", true);
    const result = await parkLocationApi.getGeoJSON();
    commit("setLoadingStatus", false);
    return commit("setGeoJSON", result.data);
  },
  async search({ commit }, params) {
    commit("setLoadingStatus", true);
    const result = await parkLocationApi.search(params);
    commit("setLoadingStatus", false);
    return commit("setSearchResults", result.data);
  },
  clearSearchResults({ commit }) {
    return commit("clearSearchResults");
  },
};

const mutations = {
  setDisplayStatus(state, status) {
    state.displayStatus = status;
  },
  setList(state, data) {
    state.parkLocationList = data;
  },
  setLoadingStatus(state, loading) {
    state.loading = loading;
  },
  setGeoJSON(state, data) {
    state.geoJSON = data;
  },
  setSearchResults(state, data) {
    state.searchResults = data;
  },
  clearSearchResults(state) {
    state.searchResults = [];
  },
};

const state = {
  displayStatus: true,
  list: [],
  geoJSON: {},
  loading: false,
  searchResults: [],
};

const getters = {};

export default {
  actions,
  getters,
  mutations,
  namespaced: true,
  state,
};
