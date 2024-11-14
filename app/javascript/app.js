

document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("contact-form");

    form.addEventListener("submit", async (event) => {
        event.preventDefault();

        const formData = new FormData(form);
        const response = await fetch(form.action, {
            method: "POST",
            body: formData,
            headers: {
                "Accept": "application/json"
            }
        });

        if (response.ok) {
            const data = await response.json();
            console.log("Success:", data); // デバッグメッセージ
            document.getElementById("notice").innerText = "Contact was successfully created.";
            document.getElementById("contacts-list").innerHTML += `
          <div>
            <p><strong>Name:</strong> ${data.name}</p>
            <p><strong>Email:</strong> ${data.email}</p>
            ${data.avatar_url ? `<p><strong>Avatar:</strong><br><img src="${data.avatar_url}" alt="Avatar"></p>` : ""}
          </div>
        `;
            form.reset();
        } else {
            const errorData = await response.json();
            console.log("Error:", errorData); // デバッグメッセージ
            let errorMessages = "<ul>";
            errorData.errors.forEach(error => {
                errorMessages += `<li>${error}</li>`;
            });
            errorMessages += "</ul>";
            document.getElementById("error-messages").innerHTML = errorMessages;
        }
    });
});