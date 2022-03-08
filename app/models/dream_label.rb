class DreamLabel < ApplicationRecord
  belongs_to :dream
  belongs_to :label

  # attr_accessor :dream, :label
end
