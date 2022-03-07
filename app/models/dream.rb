class Dream < ApplicationRecord
  belongs_to :user
  belongs_to :significance
  has_many :dream_labels
  has_many :labels, through: :dream_labels

  validates :content, presence: true, length: { minimum: 5 }
  # validates :dream_date, comparison: { lower_than: :created_at }
end
