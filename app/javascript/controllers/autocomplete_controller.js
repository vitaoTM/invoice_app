import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "hidden", "datalist"]

  connect() {
    console.log("Autocomplete controller connected")
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
