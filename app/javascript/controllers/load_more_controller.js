import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static values = { url: String }
  connect () {
    this.page = 2
  }

  fetch() {
    get(this.urlValue, {
      responseKind: 'turbo-stream',
      query: { page: this.page }
    }).then(() => {
      this.page++
    })
  }
}
