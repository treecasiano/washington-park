<template>
  <v-container>
    <v-layout row wrap>
      <v-flex xs12 sm4 pa-3>
        <slot name="list"></slot>
      </v-flex>
      <v-flex xs12 sm8 pa-3>
        <slot name="form"></slot>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
export default {};
</script>
