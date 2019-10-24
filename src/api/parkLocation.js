import axios from "axios";

export default {
  async create(data) {
    const response = await axios({
      data,
      method: "post",
      url: `/api/parkLocation`,
    });
    return response.data.result;
  },
  get(id) {
    return axios({
      method: "get",
      url: `/api/parkLocation/${id}`,
    });
  },
  getGeoJSON() {
    return axios({
      method: "get",
      url: `/api/parkLocationGeoJSON`,
    });
  },
  list() {
    return axios({
      method: "get",
      url: `/api/parkLocation`,
    });
  },
  search(params) {
    return axios({
      data: params,
      method: "post",
      url: `/api/parkLocation/search`,
    });
  },
  update(updates) {
    const url = `/api/parkLocation/${updates.gid}`;
    const data = Object.assign({}, updates);
    return axios({
      data,
      method: "put",
      url,
    });
  },
};
