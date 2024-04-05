class CreateSecrets < ActiveRecord::Migration[7.0]
  def change
    create_table :secrets, id: :uuid do |t|
      t.string :salt, null: false
      t.string :information, null: false
      t.integer :life_time, default: 10, null: false # in minutes
      t.boolean :is_accessed, default: false, null: false

      t.timestamps
    end
  end
end
