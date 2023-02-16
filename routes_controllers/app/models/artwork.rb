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
        class_name: :ArtworkShare,
        foreign_key: :artwork_id,
        primary_key: :id,
        dependent: :destroy
    )

    belongs_to(
        :artist,
        class_name: :User,
        foreign_key: :artist_id,
        primary_key: :id 
    )
    has_many :shared_viewers, through: :artwork_shares, source: :viewer 
    has_many :sharers, through: :artist, source: :artwork_shares 
    has_many :artworks_for_user_id, through: :sharers, source: :artwork 
end
