class CreateChallenges < ActiveRecord::Migration
  def self.up
    create_table :challenges do |t|
      t.integer :user_id
      t.integer :target_id

      t.timestamps
    end
    
    add_index :challenges, :user_id
    add_index :challenges, :target_id
  end

  def self.down
    drop_table :challenges
  end
end
