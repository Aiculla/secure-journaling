<template>
  <button @click="signIn">Sign In</button>
</template>

<script>
import { Auth } from 'aws-amplify';

export default {
  methods: {
    signIn() {
      Auth.federatedSignIn();
    }
  }
}
</script>
