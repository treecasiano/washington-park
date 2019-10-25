<template>
  <v-container fluid>
    <v-layout column>
      <v-flex xs12 sm4 pa-0>
        <slot name="list"></slot>
      </v-flex>
      <v-flex xs12 sm8 pa-0>
        <slot name="form"></slot>
      </v-flex>
    </v-layout>
  </v-container>
</template>
<script>
export default {};
</script>
