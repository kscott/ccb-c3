class CreateSearches < ActiveRecord::Migration
  def self.up
    create_table :searches do |t|
      t.integer :id
      t.string :name
      t.integer :ccb_id

      t.timestamps
    end
  end

  def self.down
    drop_table :searches
  end
end
