# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  author_id  :bigint           not null
#  artwork_id :bigint           not null
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Comment < ApplicationRecord
  validates :artwork_id, :author_id, :body, presence: true

  belongs_to(
    :author,
    class_name: :User
  )

  belongs_to(
    :artwork
  )

  has_many :likes, dependent: :destroy, as: :likeable
end
