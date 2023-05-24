import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import { Amplify } from 'aws-amplify';

createApp(App).use(router).mount('#app')
Amplify.configure({
    Auth: {
        region: 'us-east-1', // e.g. 'us-east-1'
        userPoolId: 'us-east-1_dEjoJ6OEo', 
        userPoolWebClientId: '6milpac6g46ehij45qulm1sdbo',
        oauth: {
            domain: 'https://secure-journaling.auth.us-east-1.amazoncognito.com',
            scope: ['email', 'openid'],
            redirectSignIn: 'http://localhost:8080', // or your domain
            redirectSignOut: 'http://localhost:8080', // or your domain
            responseType: 'code' // or 'token', 'id_token', 'token id_token'
        },
    }
});
