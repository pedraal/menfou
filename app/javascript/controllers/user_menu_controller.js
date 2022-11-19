import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "menu" ]

  connect() {
    document.addEventListener("click", () => {
      this.menuTarget.classList.add("hidden")
    })
  }

  toggle(event) {
    event.stopPropagation();
    this.menuTarget.classList.toggle("hidden")
  }
}
