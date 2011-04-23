class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :turns
      t.boolean :complete
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
