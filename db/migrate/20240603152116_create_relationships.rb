class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|

      t.bigint :follower_id, null: false
      t.bigint :followed_id, null: false

      t.timestamps
    end
  end
end
