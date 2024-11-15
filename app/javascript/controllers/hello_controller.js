import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  validateSize(event) {
    const file = event.target.files[0]
    const maxSize = parseInt(event.target.dataset.maxFileSize)

    if (file && file.size > maxSize) {
      event.target.value = ''
    }
  }

  validateMultipleSize(event) {
    const files = event.target.files
    const maxSize = parseInt(event.target.dataset.maxFileSize)
    const maxFiles = 5

    if (files.length > maxFiles) {
      alert(`You can only upload up to ${maxFiles} files`)
      event.target.value = ''
      return
    }

    for (let i = 0; i < files.length; i++) {
      if (files[i].size > maxSize) {
        event.target.value = ''
        return
      }
    }
  }
}
