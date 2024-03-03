class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.belongs_to :player, optional: true
      t.belongs_to :game
      t.integer :value, null: false

      t.timestamps
    end
  end
end
