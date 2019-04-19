import Vue from 'vue/dist/vue.js';
import VueRouter from 'vue-router';
Vue.use(VueRouter);

import Dashboard from './components/dashboard.vue';
import ProjectDetails from './components/details.vue';
import NewRequest from './components/new_request.vue';

export const mainrouter = new VueRouter({
    mode: 'history',
    routes: [
        { path: '/', component: Dashboard, name: 'dashboard'},
        { path: '/dashboard', component: Dashboard, name: 'dashboard'},
        { path: '/turtlebot', component: ProjectDetails, name: 'turtlebot'},
        { path: '/new_request', component: NewRequest, name: 'new_request'},

    ]
});