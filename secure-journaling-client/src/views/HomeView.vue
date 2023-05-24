<template>
  <div>
    <video v-if="!capturedImage" ref="video" autoplay></video>
    <button v-if="!capturedImage" @click="takePicture">Take Picture</button>
    <img v-if="capturedImage" :src="capturedImage" alt="Captured Image" />
  </div>
</template>

<script>
export default {
  name: "HomeView",
  data() {
    return {
      capturedImage: null,
    };
  },
  mounted() {
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

      // Call the lambda function
    },
  },
};
</script>
