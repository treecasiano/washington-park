import iziToast from "izitoast";
import Vue from "vue";
import VueNotifications from "vue-notifications";

import "../node_modules/izitoast/dist/css/iziToast.min.css";

/**
 * iziToast docs: http://izitoast.marcelodolce.com/
 * Vue Notifications: https://se-panfilov.github.io/vue-notifications/docs/html/usage.html
 */
function toast({ title, message, type, timeout, position = "topRight" }) {
  if (type === VueNotifications.types.warn) {
    type = "warning";
  }
  return iziToast[type]({
    position,
    title,
    message,
    timeout,
  });
}

const options = {
  success: toast,
  error: toast,
  info: toast,
  warn: toast,
};

Vue.use(VueNotifications, options);
