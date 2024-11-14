import consumer from "channels/consumer"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // 通知を受け取ったときにアラートを表示
    alert(`新しい投稿があります: ${data.name}`);
  }
});