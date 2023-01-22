class CreateSuggestions < ActiveRecord::Migration[6.1]
  def change
    create_table :suggestions do |t|
      t.text :term
      t.integer :hits
      t.references(:user, foreign_key: true)
      t.timestamps
    end
  end
end
