class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.integer :score, null: false, default: 0

      t.timestamps null: false
    end
    add_index :players, :name
  end
end
