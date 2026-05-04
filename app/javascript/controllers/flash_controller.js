import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Automatically close after 5 seconds
    this.timeout = setTimeout(() => {
      this.close()
    }, 5000)
  }

  close() {
    this.element.classList.add("animate-out", "fade-out", "slide-out-to-top-4")
    this.element.addEventListener("animationend", () => {
      this.element.remove()
    }, { once: true })
  }

  disconnect() {
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
  }
}
