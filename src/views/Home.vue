<template>
  <div>
    <MapComponent height="90" loading="loading" offsetHeight="0" width="100" />
  </div>
</template>

<script>
import MapComponent from "@/components/MapComponent.vue";

export default {
  name: "home",
  components: {
    MapComponent,
  },
};
</script>
