# == Schema Information
#
# Table name: artwork_shares
#
#  id         :bigint           not null, primary key
#  artwork_id :bigint           not null
#  viewer_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ArtworkShare < ApplicationRecord
    validates :artwork_id,:viewer_id, presence: true
    validates :artwork_id, uniqueness: {scope: :viewer_id, message: "A viewer cannot have a single artwork shared with them more than once"}

    belongs_to(
        :artwork,
        class_name: :Artwork,
        foreign_key: :artwork_id,
        primary_key: :id 
    )
    belongs_to(
        :viewer,
        class_name: :User,
        foreign_key: :viewer_id,
        primary_key: :id 
    )

    
   
   
 end
