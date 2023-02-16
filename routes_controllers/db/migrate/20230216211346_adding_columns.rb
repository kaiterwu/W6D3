class AddingColumns < ActiveRecord::Migration[7.0]
  def change
    add_column :artworks, :favorited, :boolean, default: false, null:false 
    add_column :artwork_shares, :favorited, :boolean, default: false, null:false 

  end
end
