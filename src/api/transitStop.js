import axios from "axios";

export default {
  list() {
    return axios({
      method: "get",
      url: `/api/transitStop`,
    });
  },
  getGeoJSON() {
    return axios({
      method: "get",
      url: `/api/transitStopGeoJSON`,
    });
  },
};
