import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.timeout = setTimeout(() => this.close(), 4000)
  }

  close() {
    this.element.style.transition = "opacity 0.3s ease-out, transform 0.3s ease-out"
    this.element.style.opacity = "0"
    this.element.style.transform = "translateY(-0.5rem)"
    setTimeout(() => this.element.remove(), 300)
  }

  disconnect() {
    clearTimeout(this.timeout)
  }
}
