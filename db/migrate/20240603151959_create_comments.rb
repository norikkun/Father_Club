class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.timestamps
      t.bigint :user_id, null: false
      t.bigint :post_id, null: false
      t.text :comment, null: false
    end
  end
end
