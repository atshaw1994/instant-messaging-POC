import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { timeout: { type: Number, default: 3000 } }

  connect() {
    if (this.element.textContent.trim() !== "") {
      setTimeout(() => {
        this.element.classList.add("opacity-0", "transition-opacity", "duration-1000");
      }, this.timeoutValue);
    }
  }
}
