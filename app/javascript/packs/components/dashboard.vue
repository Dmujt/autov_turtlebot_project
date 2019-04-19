<template>
    <div>
        <h5 class="blue border-bottom">Request Queue</h5>
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

            }
        }
    }
</script>
