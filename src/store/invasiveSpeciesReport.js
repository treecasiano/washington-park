import reportApi from "../api/invasiveSpeciesReport";

const actions = {
  async create({ commit, state }) {
    const record = await reportApi.create(state.record);
    console.log("record", record);
    return commit("clearRecord");
  },
  async displayData({ commit, status }) {
    return commit("setDisplayStatus", status);
  },
  async list({ commit }) {
    commit("setLoadingStatus", true);
    const result = await reportApi.list();
    commit("setLoadingStatus", false);
    return commit("setList", result.data);
  },
  async getGeoJSON({ commit }) {
    commit("setLoadingStatus", true);
    const result = await reportApi.getGeoJSON();
    commit("setLoadingStatus", false);
    return commit("setGeoJSON", result.data);
  },
  async search({ commit }, params) {
    commit("setLoadingStatus", true);
    const result = await reportApi.search(params);
    commit("setLoadingStatus", false);
    return commit("setSearchResults", result.data);
  },
  clearSearchResults({ commit }) {
    return commit("clearSearchResults");
  },
  async update({ commit, state }) {
    // TODO: clean up the response object
    const response = await reportApi.update(state.record);
    return commit("setRecord", response.data.result);
  },
};

const mutations = {
  clearRecord(state) {
    state.record = {};
  },
  setDisplayStatus(state, status) {
    state.displayStatus = status;
  },
  setList(state, data) {
    state.list = data;
  },
  setLoadingStatus(state, loading) {
    state.loading = loading;
  },
  setGeoJSON(state, data) {
    state.geoJSON = data;
  },
  setRecord(state, record) {
    state.record = record;
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
  record: {},
  searchResults: [],
};

const getters = {
  getById: state => id => {
    return state.list.find(el => {
      return el.gid === id;
    });
  },
};

export default {
  actions,
  getters,
  mutations,
  namespaced: true,
  state,
};
