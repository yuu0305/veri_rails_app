// app/javascript/channels/admin_notification_channel.js
import consumer from "channels/consumer"

document.addEventListener("turbo:load", () => {
  if (document.body.getAttribute("data-admin") === "true") {
    consumer.subscriptions.create("AdminNotificationChannel", {
      connected() {
        console.log("Connected to AdminNotificationChannel")
      },

      disconnected() {
        console.log("Disconnected from AdminNotificationChannel")
      },

      received(data) {
        console.log("Received data:", data) // For debugging
        this.showNotification(data)
      },

      showNotification(data) {
        const notification = document.createElement('div')
        notification.className = 'fixed top-4 right-4 bg-white shadow-lg rounded-lg p-4 max-w-sm w-full'
        notification.innerHTML = `
          <div class="flex items-start">
            <div class="flex-1">
              <h3 class="text-sm font-medium text-gray-900">
                New Post Created
              </h3>
              <p class="mt-1 text-sm text-gray-500">
                "${data.title}" by ${data.user}
              </p>
              <p class="mt-1 text-xs text-gray-400">
                ${data.time}
              </p>
            </div>
            <button type="button" class="ml-4 text-gray-400 hover:text-gray-500">
              <span class="sr-only">Close</span>
              <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"/>
              </svg>
            </button>
          </div>
        `

        // Add click handler to close button
        const closeButton = notification.querySelector('button')
        closeButton.addEventListener('click', () => {
          notification.remove()
        })

        document.body.appendChild(notification)

        // Auto remove after 5 seconds
        setTimeout(() => {
          if (notification.parentElement) {
            notification.remove()
          }
        }, 5000)
      }
    })
  }
})
