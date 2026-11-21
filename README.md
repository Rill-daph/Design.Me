# DESIGN.ME

Website company profile untuk **DESIGN.ME**, sebuah perusahaan jasa desain arsitektur dan perencanaan bangunan. Website menampilkan profil perusahaan, layanan, keunggulan, testimoni, informasi kontak, serta dashboard admin untuk mengelola layanan.

![DESIGN.ME](public/img/Perum.jpg)

## Fitur

- Landing page company profile yang responsif
- Informasi tentang perusahaan, visi, dan misi
- Daftar layanan yang diambil langsung dari database
- Form kontak pada halaman utama
- Registrasi dan login pengguna
- Sesi login menggunakan cookie bertanda tangan
- Pembatasan percobaan login hingga 5 kali dalam 15 menit
- Dashboard admin untuk menambah, mengubah, dan menghapus layanan
- Perlindungan akses halaman dan operasi perubahan layanan
- Tampilan menggunakan Tailwind CSS melalui CDN

## Teknologi

- Node.js
- Express.js 5
- Prisma ORM 6
- MySQL
- JavaScript dan HTML
- Tailwind CSS v4 CDN

## Struktur Proyek

```text
Company-Profile-main/
|-- index.js                 # Entry point dan konfigurasi Express
|-- config/
|   `-- db.js                # Konfigurasi Prisma Client
|-- controllers/
|   |-- auth.controller.js   # Registrasi, login, logout, dan sesi
|   `-- services.controller.js
|-- middleware/
|   `-- auth.middleware.js   # Autentikasi dan proteksi route
|-- routes/
|   |-- auth.routes.js
|   `-- services.routes.js
|-- prisma/
|   |-- schema.prisma
|   `-- migrations/
|-- public/
|   |-- index.html           # Halaman utama
|   |-- login.html
|   |-- register.html
|   |-- app.js
|   |-- auth.js
|   `-- admin.js
|-- private/
|   `-- admin.html           # Halaman dashboard admin
`-- public/img/
    `-- Perum.jpg
```

## Persyaratan

- Node.js versi 18 atau lebih baru
- npm
- MySQL
- Terminal PowerShell atau Command Prompt

## Instalasi

1. Masuk ke direktori proyek:

```powershell
cd "C:\Users\WINDOWS 11\Desktop\Company-Profile-main"
```

2. Instal dependensi:

```powershell
npm install
```

3. Buat database MySQL, misalnya `design_me`.

4. Buat file `.env` di root proyek:

```env
DATABASE_URL="mysql://USER:PASSWORD@localhost:3306/design_me"
AUTH_SECRET="ganti-dengan-string-rahasia-panjang"
NODE_ENV="development"
```

Ganti `USER`, `PASSWORD`, dan nama database sesuai konfigurasi MySQL Anda. `AUTH_SECRET` dapat dibuat melalui Node.js:

```powershell
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

5. Generate Prisma Client dan jalankan migrasi:

```powershell
npx prisma generate
npx prisma migrate deploy
```

Untuk membuat/mengembangkan database saat pengembangan:

```powershell
npx prisma migrate dev
```

## Menjalankan Website

Karena proyek belum memiliki script `npm start`, jalankan:

```powershell
node index.js
```

Buka:

- Website utama: <http://localhost:3000>
- Login admin: <http://localhost:3000/login.html>
- Registrasi: <http://localhost:3000/register.html>
- Dashboard admin: <http://localhost:3000/admin>

Halaman `/admin` akan dialihkan ke halaman login apabila pengguna belum memiliki sesi yang valid.

## Penggunaan Admin

1. Buka halaman registrasi dan buat akun.
2. Login menggunakan email dan password.
3. Setelah berhasil, Anda akan diarahkan ke dashboard admin.
4. Isi nama dan deskripsi layanan, lalu pilih **Tambah**.
5. Gunakan tombol **Ubah** atau **Hapus** pada tabel untuk mengelola layanan.
6. Pilih **Logout** untuk mengakhiri sesi.

## Endpoint API

### Autentikasi

| Method | Endpoint | Fungsi | Akses |
|---|---|---|---|
| `POST` | `/api/auth/register` | Membuat akun baru | Publik |
| `POST` | `/api/auth/login` | Login pengguna | Publik |
| `POST` | `/api/auth/logout` | Menghapus sesi login | Publik |
| `GET` | `/api/auth/me` | Mendapatkan data sesi | Login |

### Layanan

| Method | Endpoint | Fungsi | Akses |
|---|---|---|---|
| `GET` | `/api/services` | Mendapatkan semua layanan | Publik |
| `GET` | `/api/services/:id` | Mendapatkan satu layanan | Publik |
| `POST` | `/api/services` | Menambah layanan | Login |
| `PUT` | `/api/services/:id` | Mengubah layanan | Login |
| `DELETE` | `/api/services/:id` | Menghapus layanan | Login |

## Contoh Request

Membuat layanan baru:

```http
POST /api/services
Content-Type: application/json

{
  "nama": "Desain Rumah",
  "deskripsi": "Desain rumah modern, fungsional, dan sesuai kebutuhan klien."
}
```

Catatan:

- Nama layanan wajib diisi dan maksimal 100 karakter.
- Deskripsi bersifat opsional.
- Operasi `POST`, `PUT`, dan `DELETE` membutuhkan login.

## Keamanan

- Password disimpan menggunakan salt acak dan algoritma `scrypt`
- Sesi disimpan pada cookie `httpOnly`
- Token sesi ditandatangani dengan `HMAC-SHA256`
- Sesi berlaku selama 8 jam
- Login dibatasi 5 percobaan gagal selama 15 menit
- Data layanan ditampilkan menggunakan `textContent` untuk mencegah eksekusi HTML
- `AUTH_SECRET` wajib diset agar sesi tidak berubah saat server dimulai ulang
