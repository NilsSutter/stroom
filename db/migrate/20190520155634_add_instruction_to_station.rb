class AddInstructionToStation < ActiveRecord::Migration[5.2]
  def change
    add_column :stations, :instruction, :text
  end
end
