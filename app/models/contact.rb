class Contact < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  belongs_to :user
  
  validates :name, presence: true
end