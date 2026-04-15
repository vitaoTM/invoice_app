import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

export default class extends Controller {
  static values = {
    placeholder: { type: String, default: "Search..." }
  }

  connect() {
    this.select = new TomSelect(this.element, {
      create: false,
      sortField: { field: "text", direction: "asc" },
      placeholder: this.placeholderValue,
      allowEmptyOption: true,
      controlInput: '<input placeholder="Type to search..." />',
      render: {
        no_results: function(data, escape) {
          return '<div class="no-results">No client found for "' +
            escape(data.input) + '"</div>'
        }
      }
    })
  }

  disconnect() {
    if (this.select) {
      this.select.destroy()
    }
  }
}
