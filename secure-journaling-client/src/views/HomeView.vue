<template>
  <div>
    <video v-if="!capturedImage" ref="video" autoplay></video>
    <button v-if="!capturedImage" @click="takePicture">Take Picture</button>
    <img v-if="capturedImage" :src="capturedImage" alt="Captured Image" />
  </div>
</template>

<script>
import axios from 'axios'
import { Auth } from 'aws-amplify';
export default {
  name: "HomeView",
  data() {
    return {
      capturedImage: null,
      user: null
    };
  },
  async mounted() {
    try {
      this.user = await Auth.currentAuthenticatedUser().then(()=> {
        console.log('Current User:', this.user);
        this.setupCamera();
      })
      
    } catch (error) {
      console.error(error);
      // Not logged in, redirect to the login page
      // this.$router.push('/about');

    }
    this.setupCamera();
    
  },
  methods: {
    async setupCamera() {
      try {
        const video = this.$refs.video;

        // Access the webcam stream
        const stream = await navigator.mediaDevices.getUserMedia({
          video: true,
        });

        video.srcObject = stream;
      } catch (error) {
        console.error("Error accessing webcam:", error);
      }
    },
    takePicture() {
      const video = this.$refs.video;
      const canvas = document.createElement("canvas");
      const context = canvas.getContext("2d");

      // Set the canvas size to match the video dimensions
      canvas.width = video.videoWidth;
      canvas.height = video.videoHeight;

      // Draw the video frame on the canvas
      context.drawImage(video, 0, 0, canvas.width, canvas.height);

      // Convert the canvas image to a data URL
      this.capturedImage = canvas.toDataURL();

      // Stop the video stream
      video.srcObject.getTracks().forEach((track) => track.stop());
      let response = this.callLambdaFunction()
      if (response.Success) {
        console.log('Success')
      }
      else  {
        console.log(response.Message)
      }
      // Call the lambda function
      // if true create access token , create token and pass to the journal screen as a prop when navigating 
      // if false remove the captured image and make the video feed play
      
    },
    async callLambdaFunction() {
    try {
      const response = await axios.post(
        'https://jl3ba5hs3fq4ci7ao6h2j64tgm0fdftd.lambda-url.us-east-1.on.aws/',
        {
          uid: this.user.attributes.sub
        }
      );
      return response.data
      // Handle the response from the Lambda function
    } catch (error) {
      console.error(error);
      return {'Success':false,'Message': 'Didn\'t work'}
    }
  },
  },
};
</script>
