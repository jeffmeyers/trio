class AddActiveTurnToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :active_turn, :boolean, null: false, default: false
  end
end
