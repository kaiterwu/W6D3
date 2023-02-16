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
        inverse_of: :artwork_shares
    )
    belongs_to(
        :viewer,
        class_name: :User,
        inverse_of: :artwork_shares
    )

    
   
   
 end
