class Contact < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }


  # 投稿が作成された後に通知を送信
  after_create :broadcast_to_admins

  private

  def broadcast_to_admins
    # 管理者ユーザーを取得
    admins = User.where(admin: true)

    # binding.pry

    admins.each do |admin|
      # 管理者に投稿が作成されたことを通知
      ActionCable.server.broadcast("notification_channel", {
        name: self.name
      })
    end
  end
end