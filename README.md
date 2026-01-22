# 🚀 Panduan Instalasi & Deployment: Terminal_Dev

Proyek ini adalah web server berbasis **Lua** menggunakan engine **Pegasus**, yang dikemas dengan tampilan tema Terminal/Kali Linux.

## 📋 Prasyarat

Sebelum memulai, pastikan sistem Anda sudah terinstall:

* **Git**
* **Docker & Docker Compose** (Rekomendasi untuk deployment cepat)
* **Lua 5.4 & Luarocks** (Jika ingin menjalankan secara manual tanpa Docker)

---

## 🛠️ Langkah 1: Persiapan Repositori

Clone repositori dari GitHub ke mesin lokal atau server Anda:

```bash
# Clone repositori
git clone https://github.com/IshikawaUta/project_lua.git

# Masuk ke direktori proyek
cd project_lua

```

---

## 🐳 Opsi 1: Deployment Menggunakan Docker (Rekomendasi)

Metode ini paling mudah karena semua dependensi (Lua, Pegasus, Nginx) sudah dikonfigurasi di dalam container.

1. **Build dan Jalankan Container:**
Gunakan Docker Compose untuk membangun image dan menjalankan layanan.
```bash
docker-compose up -d --build

```


2. **Verifikasi Layanan:**
Cek apakah container sudah berjalan:
```bash
docker ps

```


Anda akan melihat dua container: `terminal_dev_app` (Lua) dan `terminal_dev_nginx`.
3. **Akses Web:**
Buka browser dan akses: `http://localhost` (Port 80).

---

## 💻 Opsi 2: Instalasi Manual (Local Development)

Jika Anda ingin menjalankan aplikasi langsung di sistem host (misal: Ubuntu/Debian/Kali).

1. **Jalankan Skrip Auto-Installer:**
Gunakan file `install.sh` yang sudah disediakan untuk menginstall dependensi sistem dan Pegasus Engine.
```bash
# Beri izin eksekusi
chmod +x install.sh

# Jalankan installer
./install.sh

```


2. **Jalankan Server:**
Eksekusi aplikasi menggunakan interpreter Lua 5.4.
```bash
lua5.4 app.lua

```


3. **Akses Web:**
Buka browser dan akses: `http://localhost:9090`.

---

## ⚙️ Konfigurasi Tambahan

### Struktur File Penting

* **`app.lua`**: Logika utama server, rute URL (`/`, `/projects`, dll), dan styling CSS.
* **`nginx.conf`**: Konfigurasi Reverse Proxy agar aplikasi bisa diakses melalui port 80 (HTTP standar).
* **`Dockerfile`**: Instruksi pembuatan image sistem operasi berbasis Debian untuk aplikasi Lua.

### Mengubah Port

Jika Anda ingin mengubah port aplikasi:

1. Buka `app.lua`, ubah variabel `local PORT = 9090`.
2. Buka `nginx.conf`, ubah `proxy_pass http://lua_app:9090;` sesuai port baru.
3. Buka `Dockerfile`, ubah `EXPOSE 9090`.

---

## 🛑 Cara Menghentikan Layanan

Jika menggunakan Docker, gunakan perintah berikut:

```bash
docker-compose down

```