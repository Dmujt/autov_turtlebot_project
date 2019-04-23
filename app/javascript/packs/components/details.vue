<template>
    <div>
        <h5 class="blue">TurtleBot Status</h5>
        <p class="m-0 mt-1 mb-3 xsm-text gray p-0"><strong>Note:</strong> The data shown here is updated every three seconds</p>
        <div class="row mb-3 mt-1" v-loading="isLoading">
            <div class="col-md-4 col-sm-12 center text-center pl-2 pr-2">
                <img :src="turtleBotImagePath()" height="200" /><br/>
                <span class="badge badge-warning mt-2" v-loading="isMiniLoading">Status: {{turtlebot_registration.bot_status}}</span>
            </div>
            <div class="col-md-8 col-sm-12">
                <div class="card">
                    <div class="card-body">
                        <p class="sm-text blue m-0 p-0 mb-1 mt-1">
                            <strong><i class="fas fa-globe"></i> Last Position:</strong> ({{turtlebot_registration.x_pos}}, {{turtlebot_registration.y_pos}})
                        </p>
                        <p class="sm-text blue m-0 p-0 mb-1 mt-1">
                            <strong><i class="fas fa-address-card"></i> Key Name:</strong> {{turtlebot_registration.name}}
                        </p>
                        <p class="sm-text blue m-0 p-0 mb-1 mt-1">
                            <strong><i class="fas fa-key"></i> API Key:</strong> {{turtlebot_registration.api_key}}
                        </p>
                        <p class="sm-text blue m-0 p-0 mb-1 mt-1">
                            <strong><i class="fas fa-check-circle"></i> Requests Completed:</strong> {{turtlebot_registration.requests_completed}}
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    export default {
        props: {},
        data: function() {
            return {
                turtlebot_registration: {},
                isLoading: false,
                isMiniLoading: false,
                pollingFrequency: 3000
            }
        },
        created() {
            this.isLoading = true;
            this.loadTurtleBotStatus();
        },
        methods: {
            //load the main turtlebot data
            loadTurtleBotStatus() {
                let that = this;
                that.isMiniLoading = true;
                that.$http.get('/api/turtlebot_registrations').then(res => {
                    that.turtlebot_registration = res.body;
                    that.isLoading = false;
                    that.isMiniLoading = false;
                    setTimeout(that.loadTurtleBotStatus, that.pollingFrequency);
                }, err => {
                    that.$message.error('There was an error loading the info for the Turtlebot :(');
                    that.isLoading = false;
                    that.isMiniLoading = false;
                    setTimeout(that.loadTurtleBotStatus, that.pollingFrequency);
                });
            }
        }
    }
</script>
