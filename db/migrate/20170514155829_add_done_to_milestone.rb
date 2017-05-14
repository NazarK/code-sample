class AddDoneToMilestone < ActiveRecord::Migration[5.0]
  def change
    add_column :milestones, :done, :boolean, default: false
  end
end
