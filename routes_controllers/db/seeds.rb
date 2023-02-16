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
    a = User.create!(username: "Alvin")

    aw1 = Artwork.create!(title: "The Peter Lisa", image_url:"arts.com/peter_lisa",artist: k  )
    aw2 = Artwork.create!(title: "The Mona Peter", image_url:"arts.com/mona_peter",artist: f  )
    aw3 = Artwork.create!(title: "The Alvinangelo", image_url:"arts.com/alvin",artist: a )


    aws1 = ArtworkShare.create!(viewer: f, artwork: aw1)
    aws2 = ArtworkShare.create!(viewer: k, artwork: aw2)
end 