<template>
  <v-card flat>
    <admin-layout>
      <template v-slot:list>
        <v-btn
          color="primary"
          small
          title="Add Invasive Species Report"
          @click="$router.push({
        name: 'adminObjectCreate',
        params: { mode: 'create', object: 'invasiveSpeciesReport' },
      });"
        >
          <v-icon>fas fa-plus</v-icon>&nbsp;&nbsp;Add Invasive Species Report
        </v-btn>
        <admin-list id="invasiveSpeciesReportId" :list="list" name="invasiveSpeciesReport"></admin-list>
      </template>
      <template v-slot:form>
        <form v-if="(mode==='edit' || mode==='create') && record">
          <v-text-field v-model="record.name" label="Invasive Species Report Name" required></v-text-field>
          <v-btn
            data-cy="invasiveSpeciesReportForm__cancel"
            outlined
            @click="$router.push({
              name: 'adminObject',
              params: { object: 'invasiveSpeciesReport' },
            });"
          >Cancel</v-btn>
          <v-btn
            v-if="mode==='edit'"
            data-cy="invasiveSpeciesReportForm__button--update"
            color="primary"
            @click="update"
          >Update</v-btn>
          <v-btn
            v-if="mode==='create'"
            data-cy="invasiveSpeciesReportForm__button--create"
            color="primary"
            @click="create"
          >Submit</v-btn>
        </form>
      </template>
    </admin-layout>
  </v-card>
</template>

<script>
import { get } from "lodash";
import { mapActions, mapGetters, mapMutations, mapState } from "vuex";
import AdminLayout from "./AdminLayout";
import AdminList from "./AdminList";
export default {
  components: {
    AdminLayout,
    AdminList,
  },
  computed: {
    ...mapGetters({
      getById: "invasiveSpeciesReport/getById",
    }),
    ...mapState({
      list: state => state.invasiveSpeciesReport.list,
      record: state => state.invasiveSpeciesReport.record,
    }),
  },
  async created() {
    await this.fetchList();
    this.changeRecord();
  },
  methods: {
    changeRecord() {
      const id = this.$route.params.id;
      let record = {};
      if (id) {
        record = this.getById(parseInt(id, 10));
      }
      if (record) {
        record = Object.assign({}, record);
      }
      this.setRecord(record);
    },
    async create() {
      try {
        await this.createRecord();
      } catch (e) {
        console.error(e);
        return this.$emit("failure");
      }
      this.$emit("success");
      await this.fetchList();
      this.$router.push({
        name: "adminObject",
        params: { object: "invasiveSpeciesReport" },
      });
    },
    async update() {
      try {
        await this.updateRecord();
      } catch (e) {
        console.error(e);
        return this.$emit("failure");
      }
      this.$emit("success");
      await this.fetchList();
    },
    ...mapActions({
      createRecord: "invasiveSpeciesReport/create",
      fetchList: "invasiveSpeciesReport/list",
      updateRecord: "invasiveSpeciesReport/update",
    }),
    ...mapMutations({
      setRecord: "invasiveSpeciesReport/setRecord",
    }),
  },
  props: {
    mode: {
      type: String,
    },
  },
  watch: {
    $route: "changeRecord",
  },
};
</script>
