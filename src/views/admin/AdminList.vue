<template>
  <v-list dense>
    <v-list-item v-for="item in list" :key="item.id" @click="goToEditForm(item)">
      <v-list-item-content>
        <v-list-item-title class="text-left">{{getItemName(item)}}</v-list-item-title>
      </v-list-item-content>
    </v-list-item>
  </v-list>
</template>

<script>
export default {
  methods: {
    goToEditForm(item) {
      if (
        this.$router.currentRoute.path ===
        `/admin/${this.name}/${item[this.id]}/edit`
      ) {
        return;
      }
      this.$router.push({
        name: "adminObjectEdit",
        params: { mode: "edit", object: this.name, id: item[this.id] },
      });
    },
    getItemName(item) {
      return `${item[this.itemName]}`;
    },
  },
  props: ["itemName", "list", "name", "id"],
};
</script>

