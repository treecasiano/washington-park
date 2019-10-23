<template>
  <v-layout row wrap>
    <v-flex xs12 sm4 pa-2>
      <slot name="list"></slot>
    </v-flex>
    <v-flex xs12 sm8 pa-2>
      <slot name="form"></slot>
    </v-flex>
  </v-layout>
</template>

<script>
export default {};
</script>
