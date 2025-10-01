import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["messages"];

  connect() {
    this.scrollToBottom();
  }

  scrollToBottom() {
    if (this.hasMessagesTarget) {
      this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;
    }
  }

  // Optional: scroll after Turbo Stream updates
  // Uncomment if you want to scroll after new messages arrive
  // afterMessagesUpdate() {
  //   this.scrollToBottom();
  // }
}
