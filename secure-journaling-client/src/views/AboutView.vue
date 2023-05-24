<template>
  <div>
    <button v-if="!user" @click="signIn">Sign In</button>
    <button v-if="user" @click="signOut">Sign Out</button>
  </div>
</template>

<script>
import { Auth } from 'aws-amplify';

export default {
  name: "AboutView",
  data() {
    return {
      user: null
    };
  },
  created() {
    this.getCurrentUser();
  },
  methods: {
    signIn() {
      Auth.federatedSignIn(); // It will open the AWS Hosted UI
    },
    async signOut() {
      try {
        await Auth.signOut();
        this.user = null;
        console.log("User signed out.");
      } catch (error) {
        console.error('Error signing out: ', error);
      }
    },
    async getCurrentUser() {
      try {
        const userInfo = await Auth.currentAuthenticatedUser();
        this.user = userInfo;
        console.log('User info: ', userInfo);
      } catch (error) {
        console.error('Error getting current user: ', error);
      }
    },
  },
};
</script>
