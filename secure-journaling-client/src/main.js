import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

console.log(process.env.VUE_AWS_ACCESS_KEY);
console.log(process.env.VUE_AWS_SECRET_KEY);
createApp(App).use(router).mount('#app')


