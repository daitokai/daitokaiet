class AddStepToUser < ActiveRecord::Migration
  def change
    add_column :users, :step, :integer, default: 0
  end
end
