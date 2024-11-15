# app/models/post.rb
class Post < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :content, presence: true
  
  after_create :notify_admin
  
  private
  
  def notify_admin
    return if user.admin? # Don't notify if the post creator is admin
    
    ActionCable.server.broadcast("admin_notification_channel",
      {
        title: self.title,
        user: self.user.email,
        time: I18n.l(created_at, format: :short),
        post_id: self.id
      }
    )
  end
end
