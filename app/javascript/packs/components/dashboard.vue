<template>
    <div>
        <h5 class="blue border-bottom">Request Queue</h5>
        <p class="m-0 mt-1 mb-1 gray xsm-font">Click on a request to update its status or view additional details.</p>
        <p class="m-0 mt-1 mb-1 gray xsm-font"><strong>Note:</strong>This view will auto-update every three seconds</p>
        <ul class="list-group">
            <li class="list-group-item">
                <p class="p-0 pb-1 m-0 blue"><i class="fas fa-user-cog"></i> 1. Request One</p>
                <p class="xsm-text gray p-0 m-0 mb-2">This is a description of the request.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. </p>
                <p class="xsm-text gray p-0 m-0 mb-1"><i class="fas fa-clock"></i> Started At: 4/12/19 8:50 AM</p>
                <span class="badge badge-warning">In Progress</span>
            </li>
            <li class="list-group-item">
                <p class="p-0 pb-1 m-0 blue"><i class="fas fa-user-clock"></i> 2. Request Two</p>
                <p class="xsm-text gray p-0 m-0 mb-2">This is a description of the request.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
                <p class="xsm-text gray p-0 m-0 mb-1"><i class="fas fa-clock"></i> Sent At: 4/12/19 9:00 AM</p>
                <span class="badge badge-primary">Incomplete</span>
            </li>
        </ul>
        <ul class="list-group mt-1">
            <li class="list-group-item bg-secondary white pt-1 pb-1 sm-text">Completed Requests</li>
            <li class="list-group-item">
                <p class="p-0 pb-1 m-0 green"><i class="fas fa-user-check"></i> Request Zero</p>
                <p class="xsm-text gray p-0 m-0 mb-2">This is a description of the request.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. </p>
                <p class="xsm-text gray p-0 m-0 mb-1"><i class="fas fa-clock"></i> Completed At: 4/12/19 9:00 AM</p>
                <span class="badge badge-success">Completed</span>
            </li>
            <li class="list-group-item">
                <p class="p-0 pb-1 m-0 red"><i class="fas fa-user-times"></i> Demo Request</p>
                <p class="xsm-text gray p-0 m-0 mb-2">This is a description of the request.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
                <p class="xsm-text gray p-0 m-0 mb-1"><i class="fas fa-clock"></i> Completed At: 4/12/19 9:00 AM</p>
                <span class="badge badge-danger">Cancelled</span>
            </li>
        </ul>
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
                this.$set(that, 'viewingRequest', requesth);
            },

            //update the status of a request automatically
            updateRequest() {
                let that = this;
                that.viewingRequestLoading = true;
                that.$http.put(`/api/pickup_requests/${that.viewingRequest.id}`, {
                    pickup_request: that.viewingRequest
                }).then(res => {
                    //reset
                    that.viewingRequest = {};
                    that.viewingRequestLoading = false;
                    that.isViewingRequest = true;
                    that.getQueues(true);
                    that.$message.success('Request successfully updated!');
                }, err => {
                    that.$message.error('There was an error updating the request');
                })
            }
        }
    }
</script>
