import trailApi from "../api/trail";

const actions = {
  async displayData({ commit, status }) {
    return commit("setDisplayStatus", status);
  },
  async getList({ commit }) {
    commit("setLoadingStatus", true);
    const result = await trailApi.list();
    commit("setLoadingStatus", false);
    return commit("setList", result.data);
  },
  async getGeoJSON({ commit }) {
    commit("setLoadingStatus", true);
    const result = await trailApi.getGeoJSON();
    commit("setLoadingStatus", false);
    return commit("setGeoJSON", result.data);
  },
};

const mutations = {
  setDisplayStatus(state, status) {
    state.displayStatus = status;
  },
  setList(state, data) {
    state.list = data;
  },
  setGeoJSON(state, data) {
    state.geoJSON = data;
  },
  setLoadingStatus(state, loading) {
    state.loading = loading;
  },
};

const state = {
  displayStatus: true,
  list: [],
  loading: false,
  geoJSON: {},
};

const getters = {};

export default {
  actions,
  getters,
  mutations,
  namespaced: true,
  state,
};
