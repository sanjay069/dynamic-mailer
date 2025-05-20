class RemoveLanguageFromTemplates < ActiveRecord::Migration[8.0]
  def change
    remove_column :templates, :language, :string
  end
end
