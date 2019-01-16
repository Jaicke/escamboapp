class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :member
      t.references :ad

      t.timestamps null: false
    end
  end
end
