document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("new-post-form");
    form.addEventListener("submit", async (event) => {
        event.preventDefault();

        // フォームデータを取得
        const formData = new FormData(form);

        try {
            // form.action が /posts になっているか確認
            const response = await fetch("/posts", {  // ここが /posts に設定されていることを確認
                method: "POST",
                headers: {
                    "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
                    "Accept": "application/json"
                },
                body: formData
            });

            if (!response.ok) throw new Error("投稿に失敗しました");

            const result = await response.json();

            // 新規投稿のHTMLを挿入し、フォームをリセット
            document.getElementById("posts").insertAdjacentHTML("afterbegin", `
          <div class="post">
            <p>${result.content}</p>
            <p><em>${new Date(result.created_at).toLocaleString()}</em></p>
          </div>
        `);
            form.reset();

        } catch (error) {
            console.error(error.message);
        }
    });
});