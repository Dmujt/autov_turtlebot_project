import Vue from 'vue/dist/vue.js';
import VueResource from 'vue-resource/dist/vue-resource';
import ElementUI from 'element-ui';
import locale from 'element-ui/lib/locale/lang/en';
import { mainrouter } from './routes.js';
import VueGeolocation from 'vue-browser-geolocation';
Vue.use(VueGeolocation);

Vue.use(ElementUI, { locale });
Vue.use(VueResource);
Vue.use(require('vue-moment'));

if (process.env.NODE_ENV === 'production') {
    Vue.config.devtools = false;
    Vue.config.productionTip = false;
}

// Set the token headers
Vue.http.interceptors.push((request, next) => {
    request.headers.set('X-CSRF-Token',  $('meta[name="csrf-token"]').attr('content'));
    next();
});

Vue.mixin({
    data: function() {
      return {
      }
    },
    methods: {
        turtleBotImagePath() {
            return $('meta[name="turtlebot-image-path"]').attr('content');
        }
    }
});

if ($('#application').length > 0 ){
    new Vue({
      el: '#application',
      data: {
        appLoading: false
      },
      router: mainrouter
    });
}

if ($('#deviseArea').length > 0 ){
    new Vue({
        el: '#deviseArea',
        data: {
            email:"",
            password:''
        }
    });
}