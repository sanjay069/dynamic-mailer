class CreateLanguages < ActiveRecord::Migration[8.0]
  def change
    create_table :languages do |t|
      t.string :language_name
      t.string :status

      t.timestamps
    end
  end
end
