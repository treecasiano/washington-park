<template>
  <div>
    <v-card>
      <v-card-title>
        Invasive Species Reports
        <v-spacer></v-spacer>
        <v-text-field v-model="search" append-icon="search" label="Search" single-line hide-details></v-text-field>
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
                class="reportTableRow text-left"
                tabindex="0"
              >
                <td>{{ item.gid }}</td>
                <td>{{ `${item.active ? 'Active' : 'Inactive'}` }}</td>
                <td>{{ item.date_created.slice(0, -14) }}</td>
                <td>{{ item.observation_date.slice(0, -14) }}</td>
                <td>{{ item.organism_type }}</td>
                <td>{{ item.organism_description }}</td>
                <td>{{ item.admin_notes }}</td>
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
        text: "ID",
        value: "gid",
      },
      {
        text: "Active",
        value: "active",
      },
      { text: "Date Created", value: "date_created" },
      { text: "Observation Date", value: "observation_date" },
      { text: "Organism Type", value: "organism_type" },
      { text: "Organism Description", value: "organism_description" },
      { text: "Admin Notes", value: "admin_notes" },
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
        params: { mode: "create", object: "invasiveSpeciesReport" },
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
  props: ["list", "name", "id"],
};
</script>

<style>
.reportTableRow {
  cursor: pointer;
}
.reportTableRow:focus {
  border: 2px solid var(--v-primary-lighten2) !important;
  outline: 2px solid var(--v-primary-lighten2) !important;
  border-bottom: 2px solid var(--v-primary-lighten2) !important;
}
</style>
