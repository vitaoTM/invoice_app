import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { currency: String }

  static targets = [
    "container",    // <tbody> that holds line item rows
    "template",     // <template> with a blank row
    "row",          // each <tr> line item
    "qtyInput",     // quantity inputs
    "priceInput",   // unit price inputs
    "rowSubtotal",  // per-row subtotal display
    "subtotal",     // invoice subtotal display
    "grandTotal",   // invoice grand total display
    "taxInput",     // tax amount input
    "destroyField"  // hidden _destroy fields
  ]

  connect() {
    // Calculate totals when the form first loads
    this.recalculate()
  }

  // ---- Add a new blank row ----
  add(event) {
    try {
      event.preventDefault()

      const content = this.templateTarget.innerHTML
      const uniqueId = new Date().getTime()
      const newRow = content.replace(/NEW_RECORD/g, uniqueId)

      this.containerTarget.insertAdjacentHTML("beforeend", newRow)

      // lastElementChild is reliable here — Stimulus's MutationObserver is async
      // so rowTargets won't include the new row until the next microtask
      const lastRow = this.containerTarget.lastElementChild
      const descInput = lastRow?.querySelector("input[name*='description']")
      if (descInput) descInput.focus()

      this.recalculate()
    } catch (error) {
      console.error("[line-items] add() failed:", error)
    }
  }

  // ---- Remove a row ----
  remove(event) {
    try {
      event.preventDefault()
      const row = event.target.closest("[data-line-items-target='row']")
      if (!row) return

      const destroyInput = row.querySelector("input[name*='_destroy']")
      const idInput = row.querySelector("input[name*='[id]']")

      if (idInput && idInput.value) {
        // Persisted record — don't remove from DOM, just mark for destruction
        destroyInput.value = "1"
        row.style.display = "none"
      } else {
        row.remove()
      }

      this.recalculate()
    } catch (error) {
      console.error("[line-items] remove() failed:", error)
    }
  }

  // ---- Recalculate all totals ----
  recalculate() {
    let subtotal = 0
    // Direct DOM query ensures newly inserted rows are always included,
    // even before Stimulus's MutationObserver registers them as targets
    const rows = this.containerTarget.querySelectorAll("[data-line-items-target='row']")

    rows.forEach((row) => {
      // Skip rows marked for destruction
      const destroyInput = row.querySelector("input[name*='_destroy']")
      if (destroyInput && destroyInput.value === "1") return

      const qty = parseFloat(
        row.querySelector("input[name*='quantity']")?.value
      ) || 0
      const price = parseFloat(
        row.querySelector("input[name*='unit_price']")?.value
      ) || 0
      const rowTotal = qty * price
      subtotal += rowTotal

      // Update the row's subtotal display
      const subtotalEl = row.querySelector(
        "[data-line-items-target='rowSubtotal']"
      )
      if (subtotalEl) {
        subtotalEl.textContent = `$ ${rowTotal.toFixed(2)}`
      }
    })

    // Update invoice subtotal
    if (this.hasSubtotalTarget) {
      this.subtotalTarget.textContent = `$ ${subtotal.toFixed(2)}`
    }

    // Update grand total (subtotal + tax)
    const tax = parseFloat(this.hasTaxInputTarget ? this.taxInputTarget.value : 0) || 0
    if (this.hasGrandTotalTarget) {
      this.grandTotalTarget.textContent = `${this.currencyValue} $ ${(subtotal + tax).toFixed(2)}`
    }
  }
}
