import Vue from 'vue/dist/vue.js';
import VueRouter from 'vue-router';
Vue.use(VueRouter);

import Dashboard from './components/dashboard.vue';
import ProjectDetails from './components/details.vue';
import BlocklyDemo from './components/blockly.vue';

export const mainrouter = new VueRouter({
    mode: 'history',
    routes: [
        { path: '/', component: Dashboard, name: 'dashboard'},
        { path: '/details', component: ProjectDetails, name: 'details'},
        { path: '/blockly', component: BlocklyDemo, name: 'blcokly'},

    ]
});