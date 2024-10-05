class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  enum status: { active: 0, cancelled: 1 }
end
