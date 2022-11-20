import { Controller } from "@hotwired/stimulus"
import { get, destroy } from "@rails/request.js"

export default class extends Controller {
  static values = { showUrl: String, showUserUrl: String, editUrl: String }

  show() {
    window.location = this.showUrlValue
  }

  showUser() {
    window.location = this.showUserUrlValue
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
