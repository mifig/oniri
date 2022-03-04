class Dream < ApplicationRecord
  belongs_to :user
  belongs_to :significance
  has_and_belongs_to_many :labels

  validates :content, presence: true, length: { mininum: 5 }
  # validates :dream_date, comparison: { lower_than: :created_at }
end
