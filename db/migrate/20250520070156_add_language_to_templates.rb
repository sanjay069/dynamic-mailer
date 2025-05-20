class AddLanguageToTemplates < ActiveRecord::Migration[8.0]
  def change
    add_reference :templates, :language, foreign_key: true
  end
end
