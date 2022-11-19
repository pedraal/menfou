import { Controller } from "@hotwired/stimulus"
import { get, destroy } from "@rails/request.js"

export default class extends Controller {
  static values = { editUrl: String, showUrl: String }

  show() {
    window.location = this.showUrlValue
  }

  edit() {
    get(this.editUrlValue, {
      responseKind: 'turbo-stream'
    })
  }

  destroy() {
    destroy(this.showUrlValue, {
      responseKind: 'turbo-stream'
    })
  }
}
