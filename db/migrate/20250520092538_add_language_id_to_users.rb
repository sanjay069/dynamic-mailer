class AddLanguageIdToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :language_id, :integer
  end
end
