# Share `Maaf ya, Piee`

This is a tiny static site. To let "anyone who has the link" access it, you have two simple options:

1) Share on your local network (anyone on the same Wi‑Fi/LAN)

- Open PowerShell in this folder (`C:\Piee`).
- Run the provided script:

```powershell
.\serve.ps1
```

This prints the `localhost` URL and the machine's LAN IP (e.g. `http://192.168.1.42:8000`). Anyone on the same network can open that LAN URL in their browser.

Notes:
- Requires Python 3 installed and on PATH (the script runs `python -m http.server 8000`).
- If Windows blocks the script: run `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned` (or unblock the file), or run the command manually: `python -m http.server 8000`.

2) Make it accessible publicly

- GitHub Pages (recommended for a free, permanent public link):
  1. Create a new Git repository and push the `C:\Piee` contents (or this folder) to GitHub.
  2. In GitHub repository Settings → Pages → choose the `main` branch / root and save.
  3. The site will be available at `https://<your-account>.github.io/<repo-name>/`.

- ngrok / localtunnel (temporary public tunnel):
  - Start a local server (see step 1), then run `ngrok http 8000` (requires installing ngrok). It gives you a public URL that tunnels to your machine.

Pick the option that fits you. If you want, I can:
- add a tiny `index.html` snippet for GitHub Pages compatibility,
- or generate a one-click GitHub repo + instructions (you'll still need to push the code),
- or add a small automated script to try to open a browser tab when serving.

# Maaf ya Piee


Automatic repo & deploy helpers included
-------------------------------------
I added helper files so you can create a GitHub repo and auto-deploy to Pages easily:

- `.gitignore` — common ignores.
- `deploy.ps1` — PowerShell helper: initializes git, commits, and uses the GitHub CLI (`gh`) to create a remote repo and push.
- `deploy.sh` — Bash helper with similar behavior.
- `.github/workflows/pages.yml` — GitHub Actions workflow that deploys the repository root to GitHub Pages when you push to `main`.

Quick steps to create a public repo and deploy
1. Make sure you have `git` and `gh` (GitHub CLI) installed and authenticated (`gh auth login`).
2. From `C:\Piee` run (PowerShell):

```powershell
.\deploy.ps1 -RepoName MyRepo -Public
```

or (Linux/macOS / Git Bash):

```bash
./deploy.sh MyRepo --public
```

3. After pushing, GitHub Actions will deploy your content to GitHub Pages. The Pages URL will appear in your repo Settings → Pages.

If you prefer I make the repo for you, I can generate the exact git commands or a script — but I cannot push on your behalf without your credentials/gh auth. If you want, I can guide you through the gh auth and run commands locally.
Halaman sederhana dengan tema "Maaf ya Piee". Buka `index.html` di browser untuk melihat pesan.

File utama:
- `index.html` — halaman utama tema pink dengan pesan maaf.
- `styles.css` — styling tema pink.
  
Untuk membuka: klik dua kali `c:\Piee\index.html` atau buka file tersebut di browser pilihanmu.

Menampilkan gambar saat tombol Keluar ditekan:

- Tombol "Keluar" sekarang akan memunculkan sebuah gambar (modal). Agar gambar ini muncul, simpan lampiran gambar yang kamu kirim sebelumnya ke folder `c:\Piee\images` dengan nama file `bye.jpg`.
- Contoh path akhir: `c:\Piee\images\bye.jpg`.
- Jika gambar tidak ditemukan, akan muncul pesan instruksi di modal.

Langkah cepat untuk menaruh gambar (Windows PowerShell):

```powershell
# buat folder images jika belum ada
New-Item -ItemType Directory -Path C:\Piee\images -Force

# kemudian salin file yang kamu download dari lampiran ke folder itu, misalnya:
Copy-Item -Path C:\Users\you\Downloads\lampiran.jpg -Destination C:\Piee\images\bye.jpg
```

Setelah itu buka `c:\Piee\index.html` di browser dan klik tombol "Keluar" — gambarmu akan muncul di modal.
