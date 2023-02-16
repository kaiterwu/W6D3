class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :author, foreign_key: {to_table: :users}, null: false, index: true
      t.references :artwork, foreign_key: {to_table: :artworks}, null: false, index: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
