class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.float :amount, {null: false, precision: 9, scale: 2 }
      t.integer :bidder_id, { null: false }
      t.integer :item_id, { null: false }

      t.timestamps
    end

    add_index :bids, :bidder_id
  end
end
