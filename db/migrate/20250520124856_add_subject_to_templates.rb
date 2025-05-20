class AddSubjectToTemplates < ActiveRecord::Migration[8.0]
  def change
    add_column :templates, :subject, :string
  end
end
