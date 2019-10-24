const actions = {};

const mutations = {
  setCenter(state, center) {
    state.center = center;
  },
  setDisplayStatus(state, status) {
    state.displayStatus = status;
  },
  setUserCoordinates(state, coordinates) {
    state.userLatitude = coordinates.latitude;
    state.userLongitude = coordinates.longitude;
  },
};

const state = {
  center: [45.5155, -122.715],
  displayStatus: false,
  userLatitude: null,
  userLongitude: null,
  list: [],
  geoJSON: {},
  loading: false,
  record: {},
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
