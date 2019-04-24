<template>
    <div>
        <h5 class="blue border-bottom">Request Queue</h5>
        <p class="m-0 mt-1 mb-1 gray xsm-text">Tap on a request to update its status or view additional details.</p>
        <p class="m-0 mt-1 mb-1 gray xsm-text"><strong>Note:</strong>&nbsp;This view will auto-update every three seconds</p>
        <ul class="list-group">
            <li v-for="(pickupre , idx) in requestQueue" :key="pickupre.id" class="list-group-item d-flex justify-content-between align-items-center" @click="viewRequest(pickupre)">
                <template v-if="pickupre.rstatus === 'in_progress'">
                    <p class="p-0 m-0 blue xsm-text"><i class="fas fa-cog fa-spin"></i>&nbsp;{{pickupre.title}}</p>
                    <span class="badge badge-warning">In Progress</span>
                </template>
                <template v-else-if="pickupre.rstatus === 'incomplete'">
                    <p class="p-0 m-0 blue xsm-text"> {{idx}})&nbsp;{{pickupre.title}}<br/>
                    <i class="fas fa-clock"></i> Sent At:  {{ pickupre.created_at | moment('MM/DD/YY, h:mm:ss a') }}</p>
                    <span class="badge badge-primary">Incomplete</span>
                </template>
            </li>
        </ul>
        <ul class="list-group mt-1">
            <li class="list-group-item bg-secondary white pt-1 pb-1 sm-text">Completed Requests</li>
            <li v-for="pickupre in completedRequests" :key="pickupre.id" class="list-group-item d-flex justify-content-between align-items-center" @click="viewRequest(pickupre)">
                <template v-if="pickupre.rstatus === 'cancelled'">
                    <p class="p-0 m-0 red xsm-text"><i class="fas fa-user-times"></i>&nbsp; {{pickupre.title}}<br/>
                    <i class="fas fa-clock"></i> Cancelled At:  {{ pickupre.updated_at | moment('MM/DD/YY, h:mm:ss a') }}</p>
                    <span class="badge badge-danger">Cancelled</span>
                </template>
                <template v-else>
                    <p class="p-0 m-0 green xsm-text"><i class="fas fa-user-check"></i> &nbsp;{{pickupre.title}}<br/>
                    <i class="fas fa-clock"></i> Completed At:  {{ pickupre.updated_at | moment('MM/DD/YY, h:mm:ss a') }}</p>
                    <span class="badge badge-success">Completed</span>
                </template>
            </li>
        </ul>
        <el-dialog
            :title="`Request: ${mockViewingRequest.title}`"
            :visible.sync="isViewingRequest"
            width="300px">
            <p class="gray xsm-text p-0 m-0 mb-1">{{mockViewingRequest.description}}</p>
            <p class="gray xsm-text p-0 m-0 mb-1">Location: ({{mockViewingRequest.x_coordinate}}, {{mockViewingRequest.y_coordinate}})</p>
            <p class="gray xsm-text p-0 m-0 mb-1" v-if="mockViewingRequest.rstatus === 'incomplete'"><i class="fas fa-clock"></i> Requested At: {{ mockViewingRequest.created_at | moment('MM/DD/YY, h:mm:ss a') }}</p>
            <p class="blue xsm-text p-0 m-0 mb-1" v-if="mockViewingRequest.rstatus === 'in_progress'"><i class="fas fa-clock"></i> Last Updated At: {{ mockViewingRequest.updated_at | moment('MM/DD/YY, h:mm:ss a') }}</p>
            <p class="green xsm-text p-0 m-0 mb-1t" v-if="mockViewingRequest.rstatus === 'completed'"><i class="fas fa-clock"></i> Completed At: {{ mockViewingRequest.updated_at | moment('MM/DD/YY, h:mm:ss a') }}</p>
            <p class="red xsm-text p-0 m-0 mb-1" v-if="mockViewingRequest.rstatus === 'cancelled'"><i class="fas fa-clock"></i> Cancelled At: {{ mockViewingRequest.updated_at | moment('MM/DD/YY, h:mm:ss a') }}</p>
            <span slot="footer" class="dialog-footer">
                <el-button size="small" v-if="(mockViewingRequest.rstatus === 'in_progress')" type="success" @click="updateRequest('completed')">Set As Completed</el-button>
                <el-button size="small"  v-if="(mockViewingRequest.rstatus === 'incomplete' || mockViewingRequest.rstatus === 'in_progress')" type="danger" @click="updateRequest('cancel')">Cancel</el-button>
            </span>
        </el-dialog>

    </div>
</template>
<script>
    export default {
        props: {},
        data: function() {
            return {
                requestQueue: [],
                completedRequests: [],
                isLoading: false,
                //
                viewingRequestLoading: false,
                isViewingRequest: false, //viewing request popup controller and timeout loading
                viewingRequest: {},
                pollingFrequency: 3000
            }
        },
        created() {
            //on load, get the requests
            this.getQueues();
        },
        computed: {
            //viewingRequest fill
            mockViewingRequest() {
                return (this.viewingRequest || {});
            }
        },
        methods: {
            /**
             *  pull all the requests and display in their corresponding locations
             * @param no_poll is another poll increment should not be scheduled
             * */
            getQueues(no_poll) {
                let that = this;
                that.isLoading = true;
                if (!that.isViewingRequest) {
                    //one request - two types of queues received
                    that.$http.get('/api/pickup_requests').then(res => {
                        that.$set(that, 'requestQueue', res.body.req_queue);
                        that.$set(that, 'completedRequests', res.body.completed_reqs);
                        that.isLoading = false;
                        that.viewingRequest = {};
                        if (!no_poll) {
                            setTimeout(that.getQueues, that.pollingFrequency);
                        }
                    }, err => {
                        that.$message.error('There was an error loading the queue');
                    });
                } else {
                    //still poll
                    if (!no_poll){
                        setTimeout(that.getQueues, that.pollingFrequency);
                    }
                }
            },

            /**
             * open a request to view/update in the modal
             * @param requesth The request object
             */
            viewRequest(requesth) {
                this.isViewingRequest = true;
                this.$set(this, 'viewingRequest', requesth);
            },

            /**
             * update the status of a request automatically
             * * @param state_update state to set
             */
            updateRequest(state_update) {
                let that = this;
                that.viewingRequestLoading = true;
                that.$http.put(`/api/pickup_requests/${that.viewingRequest.id}/${state_update}`).then(res => {
                    //reset
                    that.viewingRequest = {};
                    that.viewingRequestLoading = false;
                    that.isViewingRequest = false;
                    that.getQueues(true);
                    that.$message.success('Request successfully updated!');
                }, err => {
                    that.viewingRequestLoading = false;
                    that.$message.error('There was an error updating the request');
                })
            }
        }
    }
</script>
