=begin

      t.belongs_to :user
      t.belongs_to :turtlebot_registration
      t.string :title 
      t.string :details
      t.float :x_coordinate
      t.float :y_coordinate
      t.integer :rstatus, default: 0

      t.timestamps
=end
class PickupRequest < ApplicationRecord
    belongs_to :user
    belongs_to :turtlebot_registration

    enum rstatus: [:incomplete, :in_progress, :completed]

    #status = complete
    def set_complete
        self.update_attribute(:rstatus, :completed)
    end

    #status = incomplete
    def set_incomplete
        self.update_attribute(:rstatus, :incomplete)
    end

    #status = in_progress
    def set_in_progress
        self.update_atttribute(:rstatus, :in_progress)
    end

end
