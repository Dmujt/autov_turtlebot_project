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

    #select the next request in the queue to send to the TurtleBot
    #implement scheduling algorithm here!
    def self.next_in_queue
        PickupRequest.where(:rstatus => :incomplete).order(:created_at).first
    end

    #returns a json will a list of all completed and queued requests
    def self.get_all_queues
        {
            'req_queue' => PickupRequest.where(:rstatus => [:incomplete, :in_progress]).order(:created_at),
            'completed_reqs' => PickupRequest.where(:rstatus => [:completed]).order(:created_at)
        }
    end

end
