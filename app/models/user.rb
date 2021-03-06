class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :dream_labels, dependent: :destroy
  has_many :dreams
  has_many :labels
  has_many :significances

  has_one_attached :photo
end
