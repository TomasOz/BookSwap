import consumer from "./consumer";

let chatChannel;

// Expose openChat as a global function
window.openChat = function(recipientId, recipientUsername) {
  document.getElementById('chat-modal').style.display = 'block';
  document.getElementById('chat-recipient-username').innerText = recipientUsername;

  // Connect to the chat channel
  chatChannel = consumer.subscriptions.create(

    { channel: "PrivateChatChannel", user_id: USER_ID, recipient_id: recipientId },
    {
      connected() {
        // Called when the subscription is ready for use
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        // Append received message to chat
        const messages = document.getElementById('chat-messages');
        messages.innerHTML += `<p><strong>${data.user}:</strong> ${data.message}</p>`;
        messages.scrollTop = messages.scrollHeight; // Scroll to the bottom
      },

      send_message(message) {
        const messages = document.getElementById('chat-messages');
        messages.innerHTML += `<p><strong>You:</strong> ${message}</p>`;
        messages.scrollTop = messages.scrollHeight; // Scroll to the bottom
        this.perform('send_message', { message: message, recipient_id: recipientId, user_id: USER_ID });
      }
    }
  );
}

// Attach event listener for sending chat messages
document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('send-chat').addEventListener('click', () => {
    const messageInput = document.getElementById('chat-input');
    const message = messageInput.value;

    if (chatChannel) {
      chatChannel.send_message(message);
      messageInput.value = ''; // Clear input
    }
  });
});

// Function to close chat modal
window.closeChat = function() {
  document.getElementById('chat-modal').style.display = 'none';
  if (chatChannel) {
    chatChannel.unsubscribe();
  }
}
