class User < ApplicationRecord
  has_one_attached :profile_image

  validates :email, presence: true, 
  format: { with: URI::MailTo::EMAIL_REGEXP }, 
  uniqueness: true
end
