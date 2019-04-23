class Api::ApiController < ActionController::API
  before_action :authenticate_application

  protected

  #
  # makes sure the reuest has correct authentication methods
  #
  def authenticate_application
    #setup authentication check
    @reg = TurtlebotRegistration.find_by_api_key(request.headers['X-API-KEY']) if request.headers['X-API-KEY']
    if !@reg.nil? || !current_user.nil?
      #get TB locations and update if available
      unless @reg.nil?
        @reg.update_attributes(
          :x_pos => request.headers['X-BOT-LAT'].to_f,
          :y_pos => request.headers['X-BOT-LON'].to_f,
          :bstatus => (request.headers['X-BOT-STATE']).to_sym
        )
      end
      return (@reg || current_user)
    else
      head status: :unauthorized
      return false
    end
  end


end
  