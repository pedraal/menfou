import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static values = { url: String }

  fetchModal(event) {
    event.preventDefault()
    get(this.urlValue, {
      responseKind: 'turbo-stream'
    }).then(() => {
      setTimeout(() => {
        document.querySelector('#new-post-modal textarea').focus()
      }, 50);
    })
  }
}
