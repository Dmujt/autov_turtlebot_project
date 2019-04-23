class Api::PickupRequestsController < Api::ApiController
    #before_action :authenticate_application
    #skip_before_filter :verify_authenticity_token
  
    #GET /api/pickup_requests
    def index 
        render json: PickupRequest.get_all_queues
    end

    # get the last request to be completed by the TurtleBot
    #GET /api/pickup_requests/last
    def last_req
        render json: PickupRequest.next_in_queue
    end

    #GET /api/pickup_requests/:id
    def show
        render json: PickupRequest.find(params[:id])
    end

    #create a new request
    #POST /api/pickup_requests
    def create 
        pr = PickupRequest.new(pickup_params)
        pr.user_id = current_user.id
        if pr.save
            render json: pr, status: :ok
        else
            render json: {message: pr.error}, status: :bad_request
        end
    end

    #update status of a request
    # set rstatus, turtlebot coordinates
    #PUT /api/pickup_requests/:id
    def update
        pr = PickupRequest.find(params[:id])
        pr.turtlebot_registration_id = @reg.id
        if pr.update_attributes(pickup_params)
            render json: pr, status: :ok
        else
            render json: {message: pr.error}, status: :bad_request
        end
    end

    private

    def pickup_params
        params.require(:pickup_request).permit(
            :rstatus,
            :title,
            :details,
            :x_coordinate,
            :y_coordinate
        )
    end
end
  