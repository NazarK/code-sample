module ApplicationHelper
  def self.last_update_timestamp    
    [List.maximum(:updated_at).to_i, Card.maximum(:updated_at).to_i, Slot.maximum(:updated_at).to_i, Workflow.maximum(:updated_at).to_i, Milestone.maximum(:updated_at).to_i].max
  end
end
