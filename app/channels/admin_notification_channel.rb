# app/channels/admin_notification_channel.rb
class AdminNotificationChannel < ApplicationCable::Channel
  def subscribed
    if current_user&.admin?
      stream_from "admin_notification_channel"
    end
  end

  def unsubscribed
    stop_all_streams
  end
end
# app/channels/admin_notification_channel.rb
class AdminNotificationChannel < ApplicationCable::Channel
  def subscribed
    if current_user&.admin?
      stream_from "admin_notification_channel"
    end
  end

  def unsubscribed
    stop_all_streams
  end
end
