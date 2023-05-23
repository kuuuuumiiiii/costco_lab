class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :reported_id, null: false
      t.integer :reporter_id, null: false
      t.text :reason
      t.boolean :checked, null: false
      t.timestamps
    end
  end
end
