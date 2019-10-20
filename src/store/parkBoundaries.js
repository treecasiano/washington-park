const actions = {
  async displayData({ commit, status }) {
    return commit("setDisplayStatus", status);
  },
};

const mutations = {
  setDisplayStatus(state, status) {
    state.displayStatus = status;
  },
};

const state = {
  displayStatus: true,
};

const getters = {};

export default {
  actions,
  getters,
  mutations,
  namespaced: true,
  state,
};
