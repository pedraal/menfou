import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { searchUrl: String }
  static targets = [ "query" ]

  search() {
    window.location = this.searchUrlValue + "?q=" + this.queryTarget.value
  }
}
