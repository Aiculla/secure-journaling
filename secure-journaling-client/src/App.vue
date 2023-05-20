<template>
  <img alt="Vue logo" src="./assets/logo.png">
  <HelloWorld msg="Welcome to Your Vue.js App"/>
</template>

<script>
import HelloWorld from './components/HelloWorld.vue'

export default {
  name: 'App',
  components: {
    HelloWorld
  }
}


//Components for the app 
// Login Screen 
// Signup Screen 
// Journaling Screen 
// MFA SCreen
// Facial Recognition Screen 
// How to implement facial recognition
// Use amazon Rekognition with the initial vide and then save the facial attributes in a db, whenever the user logs in then check the face against the facial aatributs and go off the confidence score


// Next steps, create the login screen for the and connect amazon cognito for login, do logic for requiring mfa to the facial recognition screen

</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
