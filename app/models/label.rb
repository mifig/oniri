class Label < ApplicationRecord
  belongs_to :user
  has_many :dream_labels, dependent: :destroy
  has_many :dreams, through: :dream_labels
end
