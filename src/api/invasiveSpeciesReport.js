import axios from "axios";

export default {
  async create(data) {
    const response = await axios({
      data,
      method: "post",
      url: `/api/invasiveSpeciesReport`,
    });
    return response.data.result;
  },
  get(id) {
    return axios({
      method: "get",
      url: `/api/invasiveSpeciesReport/${id}`,
    });
  },
  getGeoJSON() {
    return axios({
      method: "get",
      url: `/api/invasiveSpeciesReportGeoJSON`,
    });
  },
  list() {
    return axios({
      method: "get",
      url: `/api/invasiveSpeciesReport`,
    });
  },
  update(updates) {
    const url = `/api/invasiveSpeciesReport/${updates.gid}`;
    const data = Object.assign({}, updates);
    return axios({
      data,
      method: "put",
      url,
    });
  },
};
