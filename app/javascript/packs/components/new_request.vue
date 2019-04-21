<template>
    <div>
        <h5 class="blue border-bottom">New Request</h5>
        <div class="form-group">
            <label class="gray">Request Title</label>
            <el-input placeholder="Please input something" v-model="edittingRequest.title"></el-input>
        </div>
        <div class="form-group">
            <label class="gray">Request Description</label>
            <el-input placeholder="Optional" :rows="2" type="textarea" v-model="edittingRequest.details"></el-input>
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
                    y_coordinate: undefined
                },
                isLoading: false
            }
        },
        methods: {
            //form validation
            isValidated() {
                if (this.title) {
                    if (this.x_coordinate !== undefined && this.y_coordinate !== undefined) {
                        return true;
                    }else {
                        that.$message.error('Please enter a valid x and y coordinate');
                        return false;
                    }
                } else {
                    that.$message.error('Please enter a valid title for the request');
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
                        that.edittingRequest = {
                            title: "",
                            details: "",
                            x_coordinate: undefined,
                            y_coordinate: undefined
                        };
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
