class Subscription < ApplicationRecord
    belongs_to :user
  
    validates :plan, presence: true
    validates :starts_at, presence: true
    validates :ends_at, presence: true
  end
  