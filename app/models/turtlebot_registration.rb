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

    # set the api key for the TurtleBot
    def set_api_key
        require 'securerandom'
        random_string = SecureRandom.uuid
        if TurtlebotRegistration.where(:api_key, random_string).count > 0
            set_api_key
        else
            self.update_attribute(:api_key, random_string)
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
end
