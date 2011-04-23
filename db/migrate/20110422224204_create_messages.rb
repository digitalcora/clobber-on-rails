class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :user_id
      t.integer :game_id
      t.string :content
      t.datetime :created_at
    end
    
    add_index :messages, :user_id
    add_index :messages, :game_id
    add_index :messages, :created_at
  end

  def self.down
    drop_table :messages
  end
end
