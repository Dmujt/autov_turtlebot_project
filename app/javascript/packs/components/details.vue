<template>
    <div>
        <h5 class="blue">TurtleBot Status</h5>
        <div class="row mb-3 mt-1">
            <div class="col-md-4 col-sm-12 center text-center pl-2 pr-2">
                <img :src="turtleBotImagePath()" height="200" /><br/>
                <span class="badge badge-warning mt-2">Status: Moving</span>
            </div>
            <div class="col-md-8 col-sm-12">
                <div class="card">
                    <div class="card-body">
                        <p class="sm-text blue m-0 p-0 mb-1 mt-1">
                            <strong><i class="fas fa-globe"></i> Last Position:</strong> (53.789345, 8.3475934)
                        </p>
                        <p class="sm-text blue m-0 p-0 mb-1 mt-1">
                            <strong><i class="fas fa-address-card"></i> Key Name:</strong> ECE813 Turtlebot
                        </p>
                        <p class="sm-text blue m-0 p-0 mb-1 mt-1">
                            <strong><i class="fas fa-key"></i> API Key:</strong> Y7843-YF111-Q7AMW-8HJP0-SP3T0
                        </p>
                        <p class="sm-text blue m-0 p-0 mb-1 mt-1">
                            <strong><i class="fas fa-check-circle"></i> Requests Completed:</strong> 5
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

            }
        }
    }
</script>
