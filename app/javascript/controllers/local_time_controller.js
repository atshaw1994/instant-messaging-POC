import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["time"]

  connect() {
    this.timeTargets.forEach((span) => {
      const utc = span.dataset.utc;
      if (utc) {
        const date = new Date(utc);
        // Format: M/D/YY h:mm AM/PM
        const month = date.getMonth() + 1;
        const day = date.getDate();
        const year = String(date.getFullYear()).slice(-2);
        let hours = date.getHours();
        const minutes = date.getMinutes().toString().padStart(2, '0');
        const ampm = hours >= 12 ? 'PM' : 'AM';
        hours = hours % 12;
        hours = hours ? hours : 12;
        span.textContent = `${month}/${day}/${year} at ${hours}:${minutes} ${ampm}`;
      }
    });
  }
}
