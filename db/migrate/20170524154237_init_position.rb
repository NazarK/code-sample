class InitPosition < ActiveRecord::Migration[5.0]
  def change
    List.all.find_each &:save
  end
end
