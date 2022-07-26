class Dream < ApplicationRecord
  include PgSearch::Model
  
  belongs_to :user
  belongs_to :significance, optional: true
  has_many :dream_labels, dependent: :destroy
  has_many :labels, through: :dream_labels

  validates :content, presence: true, length: { minimum: 5 }
  # validates :dream_date, comparison: { lower_than: :created_at }

  pg_search_scope :dream_label_search,
  against: [ :title, :content ],
  # associated_against: {
  #   label: [ :title ]
  # },
  using: {
    tsearch: { prefix: true }
  }

  def to_a
    attributes.map do |k,v|
      v.class == String ? v.gsub(/\s+/, ' ') : v
    end
  end
end
