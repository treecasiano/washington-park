import parkLocationApi from "../api/parkLocation";

const actions = {
  async create({ commit, state }) {
    const record = await parkLocationApi.create(state.record);
    return commit("setRecord", record);
  },
  async displayData({ commit, status }) {
    return commit("setDisplayStatus", status);
  },
  async list({ commit }) {
    commit("setLoadingStatus", true);
    const result = await parkLocationApi.list();
    commit("setLoadingStatus", false);
    return commit("setList", result.data);
  },
  async getGeoJSON({ commit }, params) {
    commit("setLoadingStatus", true);
    let result;
    if (params) {
      result = await parkLocationApi.getGeoDataByType(params);
    } else {
      result = await parkLocationApi.getGeoJSON();
    }
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
  async update({ commit, state }) {
    // TODO: clean up the response object
    const response = await parkLocationApi.update(state.record);
    return commit("setRecord", response.data.result);
  },
};

const mutations = {
  setDisplayStatus(state, status) {
    state.displayStatus = status;
  },
  setDisplayStatusSearchResultMarker(state, status) {
    state.displayStatusSearchResultMarker = status;
  },
  setSearchResultMarkerId(state, data) {
    state.searchResultMarkerId = data;
  },
  setSearchResultMarkerLatLng(state, data) {
    state.searchResultMarkerLatLng = data;
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
  displayStatusSearchResultMarker: false,
  list: [],
  geoJSON: {},
  loading: false,
  record: {},
  searchResults: [],
  searchResultMarkerId: null,
  searchResultMarkerLatLng: [],
};

const getters = {
  getById: state => id => {
    return state.list.find(el => {
      return el.gid === id;
    });
  },
  getByLocationType: state => locationType => {
    return state.list.find(el => {
      return el.location_type === locationType;
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
