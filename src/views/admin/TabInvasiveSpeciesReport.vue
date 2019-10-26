<template>
  <v-card flat>
    <admin-layout>
      <template v-slot:list>
        <invasive-species-report-table id="gid" :list="list" name="invasiveSpeciesReport"></invasive-species-report-table>
      </template>
      <template v-slot:form>
        <v-container>
          <v-form v-if="(mode==='edit' || mode==='create') && record" v-model="valid">
            <v-card>
              <v-card-title v-if="mode==='edit'">Admin Updates</v-card-title>
              <v-card-title v-if="mode==='create'">Create Report</v-card-title>
              <v-container>
                <div class="d-flex flex-column justify-start text-left">
                  <div>Date Created: {{record.date_created.slice(0, -14)}}</div>
                  <div>Observation Date: {{record.observation_date.slice(0, -14)}}</div>
                  <div>Observer: {{record.observer_first_name}} {{record.observer_last_name}}</div>
                  <div>Observer Email: {{record.observer_email}}</div>
                  <div>Observer Phone: {{record.organism_type}}</div>
                  <div>Organism Description: {{record.organism_description}}</div>
                  <div>Location Description: {{record.location_details}}</div>
                </div>
                <v-textarea
                  auto-grow
                  clearable
                  dense
                  rows="2"
                  v-model="record.admin_notes"
                  label="Admin Notes"
                ></v-textarea>

                <div class="d-flex justify-start mt-3">
                  <v-btn
                    class="mr-3"
                    rounded
                    data-cy="invasiveSpeciesReportForm__cancel"
                    outlined
                    @click="$router.push({
              name: 'adminObject',
              params: { object: 'invasiveSpeciesReport' },
            });"
                  >Cancel</v-btn>

                  <v-btn
                    rounded
                    v-if="mode==='edit'"
                    data-cy="invasiveSpeciesReportForm__button--update"
                    color="primary"
                    @click="update"
                    :disabled="!valid"
                  >Update</v-btn>

                  <v-btn
                    rounded
                    v-if="mode==='create'"
                    data-cy="invasiveSpeciesReportForm__button--create"
                    color="primary"
                    @click="create"
                    :disabled="!valid"
                  >Submit</v-btn>
                </div>
              </v-container>
            </v-card>
          </v-form>
        </v-container>
      </template>
    </admin-layout>
  </v-card>
</template>

<script>
import { mapActions, mapGetters, mapMutations, mapState } from "vuex";
import AdminLayout from "./AdminLayout";
import InvasiveSpeciesReportTable from "./InvasiveSpeciesReportTable";

export default {
  components: {
    AdminLayout,
    InvasiveSpeciesReportTable,
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
  data: () => ({
    valid: false,
    geomRules: [v => !!v || "Geometry is required"],
  }),
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
        // eslint-disable-next-line
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
        // eslint-disable-next-line
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

