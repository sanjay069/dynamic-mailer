class RemoveUserIdFromTemplates < ActiveRecord::Migration[8.0]
  def change
    remove_column :templates, :user_id, :integer
  end
end
