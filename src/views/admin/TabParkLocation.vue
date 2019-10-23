<template>
  <v-card flat>
    <admin-layout>
      <template v-slot:list>
        <v-btn
          color="primary"
          small
          title="Add Park Location"
          @click="$router.push({
        name: 'adminObjectCreate',
        params: { mode: 'create', object: 'parkLocation' },
      });"
        >Add Park Location</v-btn>
        <admin-list id="gid" :list="list" name="parkLocation"></admin-list>
      </template>
      <template v-slot:form>
        <form v-if="(mode==='edit' || mode==='create') && record">
          <v-text-field v-model="record.location_name" label="Park Location Name" required></v-text-field>
          <v-text-field v-model="record.location_type" label="Location Type" required></v-text-field>
          <v-text-field v-model="record.street_addr_1" label="Street Address 1"></v-text-field>
          <v-text-field v-model="record.street_addr_2" label="Street Address 2"></v-text-field>
          <v-text-field v-model="record.city" label="City"></v-text-field>
          <v-text-field v-model="record.state" label="State"></v-text-field>
          <v-text-field v-model="record.zip" label="ZIP"></v-text-field>
          <v-text-field v-model="record.url" label="Website"></v-text-field>
          <v-text-field v-model="record.image_url" label="Image URL"></v-text-field>
          <v-text-field v-model="record.hrs_of_operation" label="Hours of Operation"></v-text-field>
          <v-text-field v-model="record.description" label="Description"></v-text-field>

          <v-btn
            data-cy="parkLocationForm__cancel"
            outlined
            @click="$router.push({
              name: 'adminObject',
              params: { object: 'parkLocation' },
            });"
          >Cancel</v-btn>
          <v-btn
            v-if="mode==='edit'"
            data-cy="parkLocationForm__button--update"
            color="primary"
            @click="update"
          >Update</v-btn>
          <v-btn
            v-if="mode==='create'"
            data-cy="parkLocationForm__button--create"
            color="primary"
            @click="create"
          >Submit</v-btn>
        </form>
      </template>
    </admin-layout>
  </v-card>
</template>

<script>
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
      getById: "parkLocation/getById",
    }),
    ...mapState({
      list: state => state.parkLocation.list,
      record: state => state.parkLocation.record,
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
        params: { object: "parkLocation" },
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
      createRecord: "parkLocation/create",
      fetchList: "parkLocation/list",
      updateRecord: "parkLocation/update",
    }),
    ...mapMutations({
      setRecord: "parkLocation/setRecord",
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
