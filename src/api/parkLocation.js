import axios from "axios";

export default {
  get(id) {
    return axios({
      method: "get",
      url: `/api/parkLocation/${id}`,
    });
  },
  list() {
    return axios({
      method: "get",
      url: `/api/parkLocation`,
    });
  },
  getGeoJSON() {
    return axios({
      method: "get",
      url: `/api/parkLocationGeoJSON`,
    });
  },
  search(params) {
    return axios({
      data: params,
      method: "post",
      url: `/api/parkLocation/search`,
    });
  },
  put(updates, id) {
    const url = `/api/parkLocation/${id}`;
    const data = Object.assign({}, updates);

    return axios({
      data,
      method: "put",
      url,
    });
  },
};
