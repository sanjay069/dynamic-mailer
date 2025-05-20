class RenameSubjectToLanguageInTemplates < ActiveRecord::Migration[8.0]
  def change
    rename_column :templates, :subject, :language
  end
end
