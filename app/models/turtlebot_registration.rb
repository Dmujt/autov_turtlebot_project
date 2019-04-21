=begin
      t.string :api_key
      t.string :name

      t.float :x_pos
      t.float :y_pos

      t.timestamps
=end
class TurtlebotRegistration < ApplicationRecord
    has_many :pickup_requests

    before_create :set_api_key

    enum bstatus: [:stationary, :moving, :in_error]

    # set the api key for the TurtleBot
    def set_api_key
        require 'securerandom'
        random_string = SecureRandom.uuid
        if !TurtlebotRegistration.where(:api_key => random_string.to_s).last.nil?
            self.set_api_key
        else
            self.api_key = random_string.to_s
        end
    end

    #  
    # update the location of the TurtleBot
    # @param xpos
    # @param ypos
    def update_location(xpos, ypos)
        self.update_attributes(
            :x_pos => xpos.to_f,
            :y_pos => ypos.to_f
        )
    end

    #status of the bot (moving, completed, etc)
    def bot_status
        self.bstatus.to_s
    end

    #number of requests completed by this turtlebot
    def requests_completed
        self.pickup_requests.where(:rstatus => :completed).count
    end
end
