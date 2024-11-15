// app/javascript/controllers/task_form_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["title", "description", "status", "priority", "submit",
        "titleError", "descriptionError", "statusError", "priorityError"]

    async submitForm(event) {
        event.preventDefault()
        this.clearErrors()
        this.submitTarget.disabled = true

        try {
            const response = await fetch(this.element.action, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
                },
                body: JSON.stringify({
                    task: {
                        title: this.titleTarget.value,
                        description: this.descriptionTarget.value,
                        status: this.statusTarget.value,
                        priority: this.priorityTarget.value
                    }
                })
            })

            const data = await response.json()

            if (data.status === 'success') {
                this.handleSuccess(data)
            } else {
                this.handleErrors(data.errors)
            }
        } catch (error) {
            console.error('Error:', error)
            this.showFlashMessage('An error occurred. Please try again.', 'error')
        } finally {
            this.submitTarget.disabled = false
        }
    }

    handleSuccess(data) {
        // Add new task to the list
        document.getElementById('tasks-list').insertAdjacentHTML('afterbegin', data.task)

        // Clear form
        this.element.reset()

        // Show success message
        this.showFlashMessage(data.message, 'success')
    }

    handleErrors(errors) {
        errors.forEach(error => {
            const field = error.toLowerCase().split(' ')[0]
            const errorTarget = this[`${field}ErrorTarget`]
            if (errorTarget) {
                errorTarget.textContent = error
            }
        })
    }

    clearErrors() {
        this.element.querySelectorAll('.error-message').forEach(el => el.textContent = '')
    }

    showFlashMessage(message, type) {
        const flashDiv = document.getElementById('flash-messages')
        const messageClass = type === 'success' ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'

        flashDiv.innerHTML = `
      <div class="flash-message ${messageClass} px-4 py-3 rounded relative" 
           data-controller="flash">
        <span class="block sm:inline">${message}</span>
        <button class="absolute top-0 bottom-0 right-0 px-4 py-3" 
                data-action="flash#dismiss">
          <span class="sr-only">Dismiss</span>
          <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                  d="M6 18L18 6M6 6l12 12"/>
          </svg>
        </button>
      </div>
    `
    }
}
