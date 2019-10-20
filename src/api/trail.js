import axios from "axios";

export default {
  list() {
    return axios({
      method: "get",
      url: `/api/trail`,
    });
  },
  getGeoJSON() {
    return axios({
      method: "get",
      url: `/api/trailGeoJSON`,
    });
  },
};
