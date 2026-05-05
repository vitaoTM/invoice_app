import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { id: Number, name: String }

  connect() {
    document.dispatchEvent(new CustomEvent("client:created", {
      bubbles: true,
      detail: { id: this.idValue, name: this.nameValue }
    }))
    this.element.remove()
  }
}
