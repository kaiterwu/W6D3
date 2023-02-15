# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
ActiveRecord::Base.transaction do 
    User.destroy_all
    Artwork.destroy_all 
    ArtworkShare.destroy_all 

    %w(users artworks artwork_shares).each do |table_name|
        ApplicationRecord.connection.reset_pk_sequence!(table_name)
    end 

    k = User.create!(username: "Kaiter")
    f = User.create!(username: "Fahim")

    aw1 = Artwork.create!(title: "The Peter Lisa", image_url:"arts.com/peter_lisa",artist: f  )
    aw2 = Artwork.create!(title: "The Mona Peter", image_url:"arts.com/mona_peter",artist: k  )

    aws1 = ArtworkShare.create!(viewer: f, artwork: aw2)
    aws2 = ArtworkShare.create!(viewer: k, artwork: aw1)
end 