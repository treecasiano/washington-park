import Vue from "vue";
import Router from "vue-router";
import Admin from "./views/admin/Admin.vue";
import Home from "./views/Home.vue";

Vue.use(Router);

export default new Router({
  mode: "history",
  routes: [
    {
      path: "/",
      name: "home",
      component: Home,
    },
    {
      component: Admin,
      name: "admin",
      path: "/admin",
      redirect: { name: "adminObject", params: { object: "parkLocation" } },
      children: [
        {
          component: Admin,
          path: ":object",
          name: "adminObject",
          children: [
            {
              component: Admin,
              path: ":id/:mode",
              name: "adminObjectEdit",
            },
            {
              component: Admin,
              path: ":mode",
              name: "adminObjectCreate",
            },
          ],
        },
      ],
    },
  ],
});
