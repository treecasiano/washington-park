import axios from "axios";

export default {
  get(id) {
    return axios({
      method: "get",
      url: `/api/example/${id}`,
    });
  },
  list() {
    return axios({
      method: "get",
      url: `/api/example`,
    });
  },
  getGeoJSON() {
    return axios({
      method: "get",
      url: `/api/exampleGeoJSON`,
    });
  },
  put(example, id) {
    const url = `/api/example/${id}`;
    const data = Object.assign({}, example);

    return axios({
      data,
      method: "put",
      url,
    });
  },
};
