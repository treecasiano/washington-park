<template>
  <div>
    <v-card>
      <v-card-title>
        List of Park Locations
        <v-spacer></v-spacer>
        <v-text-field v-model="search" append-icon="search" label="Search" single-line hide-details></v-text-field>
        <div class="d-flex justify-left ma-4">
          <v-btn
            rounded
            color="primary"
            class="ml-5"
            title="Add Park Location"
            @click="goToCreateForm"
          >
            <v-icon>add</v-icon>&nbsp;Add Park Location
          </v-btn>
        </div>
      </v-card-title>
      <template>
        <v-data-table class="elevation-1 mt-4" :headers="headers" :items="list" :search="search">
          <template v-slot:body="{ items }">
            <tbody>
              <tr
                v-for="item in items"
                :key="item.gid"
                @click="goToEditForm(item)"
                @keyup.enter="goToEditForm(item)"
                class="locationTableRow text-left"
                tabindex="0"
              >
                <td>{{ item.location_name }}</td>
                <td>{{ item.location_type }}</td>
                <td>
                  <a :href="item.url">{{ item.url }}</a>
                </td>
                <td>{{ item.image_url }}</td>
                <td>{{ item.hrs_of_operation }}</td>
                <td>{{ item.description }}</td>
              </tr>
            </tbody>
          </template>
        </v-data-table>
      </template>
      <div ref="bottomOfTable"></div>
    </v-card>
  </div>
</template>

<script>
export default {
  data: () => ({
    search: "",
    headers: [
      {
        text: "Name",
        value: "location_name",
      },
      {
        text: "Type",
        value: "location_type",
      },
      { text: "URL", value: "url" },
      { text: "Image", value: "img_url" },
      { text: "Hours", value: "hrs_of_operation" },
      { text: "Description", value: "description" },
    ],
  }),
  methods: {
    goToCreateForm() {
      this.$refs.bottomOfTable.scrollIntoView();
      if (this.$router.currentRoute.path === `/admin/${this.name}/create`) {
        return;
      }
      this.$router.push({
        name: "adminObjectCreate",
        params: { mode: "create", object: "parkLocation" },
      });
    },
    goToEditForm(item) {
      this.$refs.bottomOfTable.scrollIntoView();
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
  },
  props: ["itemName", "list", "name", "id"],
};
</script>

<style>
.locationTableRow {
  cursor: pointer;
}
.locationTableRow:focus {
  border: 2px solid var(--v-primary-lighten2) !important;
  outline: 2px solid var(--v-primary-lighten2) !important;
  border-bottom: 2px solid var(--v-primary-lighten2) !important;
}
</style>
