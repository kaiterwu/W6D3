# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artwork < ApplicationRecord
    validates :title,:image_url,:artist_id, presence: true
    validates :title, uniqueness: {scope: :artist_id, message: 'A single user cannot have two artworks with the same title'}

    has_many(
        :artwork_shares,
        dependent: :destroy
    )

    has_many(
        :comments,
        dependent: :destroy,
        inverse_of: :artwork
      )

    belongs_to(
        :artist,
        class_name: :User
    )
    has_many :shared_viewers, through: :artwork_shares, source: :viewer 

    has_many :likes, dependent: :destroy, as: :likeable

    # has_many :sharers, through: :artist, source: :artwork_shares 
    # has_many :artworks_for_user_id, through: :sharers, source: :artwork 
end
