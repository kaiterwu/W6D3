class CreateCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :collections do |t|
      t.references :user, foreign_key: true, null: false, index:true 
      t.string :name, null: false

      t.timestamps
    end
    add_index :collections,[:user_id,:name],unique: true 

    create_table :collection_artworks do |t|
      t.references :collection, foreign_key: true, null: false, index:true 
      t.references :artwork, foreign_key: true, null: false, index:true 

      t.timestamps
    end
    add_index :collection_artworks,[:collection_id,:artwork_id], unique: true 
  end
end
