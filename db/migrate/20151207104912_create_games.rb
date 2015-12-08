class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player_x_id
      t.integer :player_o_id
      t.string :player_x_cells
      t.string :player_o_cells
      t.string :state, default: 'new'
      t.integer :winner_id

      t.timestamps null: false
    end
  end
end
