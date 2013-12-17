class AddGoalToUser < ActiveRecord::Migration
  def change
    add_column :users, :goal, :decimal, default: 60
  end
end
