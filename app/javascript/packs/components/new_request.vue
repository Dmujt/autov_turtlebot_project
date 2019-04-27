<template>
    <div>
        <h5 class="blue border-bottom">New Request</h5>
        <div class="form-group">
            <label class="gray w-100">Request Title</label>
            <el-input placeholder="Please input something" v-model="edittingRequest.title"></el-input>
        </div>
        <div class="form-group">
            <label class="gray w-100">Request Description</label>
            <el-input placeholder="Optional" :rows="2" type="textarea" v-model="edittingRequest.details"></el-input>
        </div>

        <div class="form-group">
            <label class="gray w-100">Set Coordinates</label>
            <el-input style="width: 100px" placeholder="x-coord" v-model="edittingRequest.x_coordinate"></el-input>
            <el-input  style="width: 100px" placeholder="y-coord" v-model="edittingRequest.y_coordinate"></el-input>
        </div>
        <div class="form-group">
            <label class="gray xsm-text w-100">Coordinates</label>
                <span class="xsm-text">({{edittingRequest.x_coordinate}}, {{edittingRequest.y_coordinate}})</span>
            <!--
            <el-button type="danger" size="small" @click="getLocation()" round> <i class="fas fa-street-view"></i> Set Location</el-button>
            -->
        </div>

        <div class="form-group w-100 border-top pt-3">
            <el-button size="small" type="success" @click="submitRequest()">Submit Request</el-button>
        </div>
    </div>
</template>
<script>
    export default {
        props: {},
        data: function() {
            return {
                edittingRequest: {
                    title: "",
                    details: "",
                    x_coordinate: undefined,
                    y_coordinate: undefined,
                    accuracy: undefined
                },
                isLoading: false
            }
        },
        methods: {
            /**
             * set the user's current geolocation
             */
            getLocation() {
                let that = this;
                that.isLoading = true;
                //when page is first accessed 
                //get the user's location
                that.$getLocation({
                    enableHighAccuracy: true //defaults to false
                }).then(coordinates => {
                    that.edittingRequest.x_coordinate = coordinates.lat;
                    that.edittingRequest.y_coordinate = coordinates.lng;
                    that.isLoading = false;
                });
            },
            //form validation
            isValidated() {
                if (this.edittingRequest.title) {
                    if (this.edittingRequest.x_coordinate !== undefined && this.edittingRequest.y_coordinate !== undefined) {
                        return true;
                    }else {
                        this.$message.error('Please enter a valid x and y coordinate');
                        return false;
                    }
                } else {
                    this.$message.error('Please enter a valid title for the request');
                    return false;
                }
            },

            //turn in the request
            submitRequest() {
                let that = this;
                that.isLoading = true;
                if (that.isValidated()){
                    that.$http.post('/api/pickup_requests', {
                        pickup_request: that.edittingRequest
                    }).then(res => {
                        //clear the form and turn in inform user req is done
                        that.$set(that, 'edittingRequest', {
                            title: "",
                            details: "",
                            x_coordinate: undefined,
                            y_coordinate: undefined
                        });

                        that.isLoading = false;
                        that.$message.success('Request saved! Go to the homepage to view it in queue.');
                    }, err => {
                        that.isLoading = false;
                        that.$message.error('There was an error adding this request to the queue :(');
                    });
                }
            }
        }
    }
</script>
