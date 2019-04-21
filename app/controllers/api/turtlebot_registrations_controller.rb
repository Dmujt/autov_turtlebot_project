class Api::TurtlebotRegistrationsController < Api::ApiController
    #before_action :authenticate_application
    #skip_before_filter :verify_authenticity_token
  
    #GET /api/turtlebot_registrations
    def index 
        render json: TurtlebotRegistration.includes(:pickup_requests).all.last.to_json(
            :methods => [:bot_status, :requests_completed]
        )
    end

end
  