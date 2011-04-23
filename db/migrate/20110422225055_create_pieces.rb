class CreatePieces < ActiveRecord::Migration
  def self.up
    create_table :pieces do |t|
      t.integer :player_id
      t.integer :x
      t.integer :y

      t.timestamps
    end
    
    add_index :pieces, :player_id
  end

  def self.down
    drop_table :pieces
  end
end
