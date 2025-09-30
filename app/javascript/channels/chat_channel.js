import consumer from "channels/consumer"

// Subscribe to a specific chat room
const element = document.getElementById("messages")
if (element) {
  const chatId = element.dataset.chatId
  const currentUserId = parseInt(element.dataset.currentUserId, 10)

  // Scroll to bottom on page load
  window.addEventListener("DOMContentLoaded", () => {
    element.scrollTop = element.scrollHeight
  })

  consumer.subscriptions.create({ channel: "ChatChannel", chat_id: chatId }, {
    received(data) {
      // Determine alignment and color
      const isCurrentUser = data.sender_id === currentUserId
      const alignment = isCurrentUser ? "justify-end" : "justify-start"
      const bubbleClass = isCurrentUser
        ? "bg-blue-500 text-white"
        : "bg-gray-200 text-gray-800"

      // Build the message HTML
      const html = `
        <div id="message_${data.message_id}" class="flex items-start my-2 ${alignment}">
          <div class="max-w-xs p-3 rounded-lg ${bubbleClass}">
            <div class="font-semibold text-sm mb-1">${data.sender_name}</div>
            <p>${data.body}</p>
          </div>
        </div>
      `
      element.insertAdjacentHTML("beforeend", html)
      element.scrollTop = element.scrollHeight
    }
  })
}
