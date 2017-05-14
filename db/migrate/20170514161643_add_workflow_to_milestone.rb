class AddWorkflowToMilestone < ActiveRecord::Migration[5.0]
  def change
    add_reference :milestones, :workflow, foreign_key: true
  end
end
