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
      return (@reg || current_user)
    else
      head status: :unauthorized
      return false
    end
  end


end
  