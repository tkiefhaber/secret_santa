class CreatePairs < ActiveRecord::Migration
  def change
    create_table :pairs do |t|

      t.integer :giver_id
      t.integer :receiver_id
      t.integer :group_id
      t.timestamps
    end
  end
end
