import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static values = { editUrl: String }

  edit() {
    get(this.editUrlValue, {
      responseKind: 'turbo-stream'
    })
  }
}
