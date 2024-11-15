# app/models/user.rb
class User < ApplicationRecord
  has_many :posts
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  validates :name, presence: true, 
                  length: { minimum: 2, maximum: 50 }
  validates :email, presence: true, 
                   uniqueness: { case_sensitive: false },
                   format: { with: URI::MailTo::EMAIL_REGEXP }
end
