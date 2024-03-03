class AddStateToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :state, :integer, null: false, default: 0
  end
end
