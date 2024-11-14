class NotificationChannel < ApplicationCable::Channel
  def subscribed
    if current_user&.admin?
      stream_from "notification_channel"
    else
      reject
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
