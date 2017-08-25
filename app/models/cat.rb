require 'action_view'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  # freeze ensures that constants are immutable
  CAT_COLORS = %w(black white orange brown).freeze

  validates :birth_date, :color, :name, :sex, :user_id, presence: true
  validates :color, inclusion: CAT_COLORS
  validates :sex, inclusion: %w(M F)


  has_many :rental_requests,
    class_name: :CatRentalRequest,
    dependent: :destroy

  belongs_to :owner,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User

  has_many :requesters,
  through: :rental_requests,
  source: :requester

  def age
    time_ago_in_words(birth_date)
  end
end
