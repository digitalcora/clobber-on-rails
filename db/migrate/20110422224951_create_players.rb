class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.integer :user_id
      t.integer :game_id
      t.boolean :active
      t.boolean :turn_up
      t.integer :turn_order
      t.boolean :won_game

      t.timestamps
    end
    
    add_index :players, :user_id
    add_index :players, :game_id
    add_index :players, [:user_id, :game_id], :unique => true
  end

  def self.down
    drop_table :players
  end
end
