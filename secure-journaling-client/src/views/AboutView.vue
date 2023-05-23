<template>
  <div class="about">
    <h1>This is an about page</h1>
  </div>
</template>

<script>
export default {
  mounted() {
    const secret = process.env.VUE_AWS_ACCESS_KEY;
    console.log(secret); // Output the secret value when the component is mounted
  }
};
</script>
