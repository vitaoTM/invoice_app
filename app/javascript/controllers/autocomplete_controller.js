import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "hidden", "datalist"]

  connect() {
    this.onClientCreated = ({ detail }) => {
      this.inputTarget.value = detail.name
      this.hiddenTarget.value = detail.id
    }
    document.addEventListener("client:created", this.onClientCreated)
  }

  disconnect() {
    document.removeEventListener("client:created", this.onClientCreated)
  }

  change(event) {
    const value = event.target.value
    const option = Array.from(this.datalistTarget.options).find(opt => opt.value === value)

    if (option) {
      this.hiddenTarget.value = option.dataset.id
    } else {
      this.hiddenTarget.value = ""
    }
  }
}
