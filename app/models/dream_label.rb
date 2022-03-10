class DreamLabel < ApplicationRecord
  belongs_to :dream
  belongs_to :label
  belongs_to :user
end
