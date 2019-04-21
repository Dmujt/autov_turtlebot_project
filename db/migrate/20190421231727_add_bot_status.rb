class AddBotStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :turtlebot_registrations, :bstatus, :integer, default: 0
  end
end
