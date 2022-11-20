import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { searchUrl: String }
  static targets = [ "query" ]

  search() {
    window.location = this.searchUrlValue + "?q=" + this.queryTarget.value
  }

  focus() {
    this.element.classList.remove("border-gray-200")
    this.element.classList.add("border-primary")
  }

  blur() {
    this.element.classList.remove("border-primary")
    this.element.classList.add("border-gray-200")
  }
}
