<template>
  <div>
    <v-dialog v-model="dialog" scrollable max-width="600px">
      <template v-slot:activator="{ on }">
        <v-layout column>
          <h2 class="primary--text mb-2">Help us Combat Invasive Species!</h2>
          <p>Muffin powder lollipop jelly candy tiramisu gummi bears chocolate bar toffee. Sweet roll cupcake bonbon chocolate cake macaroon.</p>

          <v-btn large rounded color="primary" dark v-on="on" class="ma-5">
            <v-icon>note_add</v-icon>&nbsp;Submit Report
          </v-btn>
        </v-layout>
      </template>
      <v-form v-model="valid" style="z-index: 100000;">
        <v-card class="elevation-0 pb-6">
          <v-container>
            <v-row>
              <v-col>
                <v-menu
                  ref="menu"
                  v-model="menu"
                  :close-on-content-click="false"
                  :return-value.sync="record.observation_date"
                  transition="scale-transition"
                  offset-y
                  min-width="290px"
                >
                  <template v-slot:activator="{ on }">
                    <v-text-field
                      :rules="fieldRules"
                      v-model="record.observation_date"
                      label="Observation Date"
                      prepend-icon="event"
                      readonly
                      v-on="on"
                      required
                    ></v-text-field>
                  </template>
                  <v-date-picker v-model="record.observation_date" no-title scrollable>
                    <v-spacer></v-spacer>
                    <v-btn text color="primary" @click="menu = false">Cancel</v-btn>
                    <v-btn text color="primary" @click="$refs.menu.save(record.observation_date)">OK</v-btn>
                  </v-date-picker>
                </v-menu>
              </v-col>
              <v-col>
                <v-select
                  :rules="fieldRules"
                  label="Organism Type"
                  v-model="record.organism_type"
                  required
                  :items="organismTypes"
                ></v-select>
              </v-col>
            </v-row>
            <v-text-field label="Your Email" v-model="record.observer_email" required></v-text-field>

            <v-row>
              <v-col>
                <v-text-field
                  cols="6"
                  label="Your First Name"
                  v-model="record.observer_first_name"
                  required
                ></v-text-field>
              </v-col>
              <v-col>
                <v-text-field
                  cols="6"
                  label="Your Last Name"
                  v-model="record.observer_last_name"
                  required
                ></v-text-field>
              </v-col>
            </v-row>

            <v-text-field
              :rules="fieldRules"
              counter="250"
              label="Organism Description"
              required
              v-model="record.organism_description"
            ></v-text-field>
            <v-textarea
              auto-grow
              clearable
              counter="250"
              label="Location Details"
              rows="2"
              v-model="record.location_details"
            ></v-textarea>
            <v-text-field label="Geometry" v-model="record.geom" required :rules="fieldRules"></v-text-field>
            <div class="d-flex justify-end mt-3">
              <v-btn class="mr-3" rounded outlined @click="cancel">Cancel</v-btn>
              <v-btn rounded color="primary" @click="create" :disabled="!valid">Submit</v-btn>
            </div>
          </v-container>
        </v-card>
      </v-form>
    </v-dialog>
  </div>
</template>

<script>
import { mapActions, mapMutations, mapState } from "vuex";
const defaultCenter = [45.5155, -122.715];

export default {
  computed: {
    ...mapState({
      record: state => state.invasiveSpeciesReport.record,
    }),
  },
  created() {},
  data: () => ({
    dialog: false,
    menu: false,
    organismTypes: ["plant", "animal"],
    valid: false,
    fieldRules: [v => !!v || "Field is required"],
  }),
  methods: {
    cancel() {
      this.dialog = false;
      this.clearRecord();
    },
    closeMapControls() {
      this.$emit("closeMapControls");
    },

    async create() {
      try {
        await this.createRecord();
        this.dialog = false;
        this.closeMapControls();
        this.setCenter(defaultCenter);
      } catch (e) {
        // eslint-disable-next-line
        console.error(e);
      }
      await this.fetchList();
    },
    ...mapActions({
      createRecord: "invasiveSpeciesReport/create",
      fetchList: "invasiveSpeciesReport/list",
    }),
    ...mapMutations({
      clearRecord: "invasiveSpeciesReport/clearRecord",
      setRecord: "invasiveSpeciesReport/setRecord",
      setCenter: "map/setCenter",
    }),
  },
};
</script>

