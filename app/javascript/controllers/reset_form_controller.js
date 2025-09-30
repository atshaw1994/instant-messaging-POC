import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // This action listens for the form submission to complete successfully via Turbo

  connect() {
    this.reset = this.reset.bind(this);
    this.element.addEventListener("turbo:submit-end", this.reset)
  }

  // Clears the form input field
  reset(event) {
    if (event.detail.success) {
      this.element.reset()
    }
  }
}