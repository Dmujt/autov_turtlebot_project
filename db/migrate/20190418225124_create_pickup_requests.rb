class CreatePickupRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :turtlebot_registrations do |t|
      t.string :api_key
      t.string :name

      t.float :x_pos
      t.float :y_pos

      t.timestamps
    end

    create_table :pickup_requests do |t|

      t.belongs_to :user
      t.belongs_to :turtlebot_registration
      t.string :title 
      t.string :details
      t.float :x_coordinate
      t.float :y_coordinate
      t.integer :rstatus, default: 0

      t.timestamps
    end
  end
end
