# Dokumentasi API Hirup Aing

## Informasi Umum

Base URL: `https://api.hirup-aing.com/v1` (contoh)

## Autentikasi

API ini menggunakan autentikasi berbasis token. Sebagian besar endpoint membutuhkan token Bearer untuk diakses. Token dapat diperoleh melalui endpoint login.

**Header Authorization**:
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

## Format Respons

Semua respons API menggunakan format JSON. Format umum adalah:

### Respons Sukses:

```json
{
  "success": true,
  "message": "Pesan sukses (opsional)",
  "data": {
    // Data respons
  }
}
```

### Respons Error:

```json
{
  "success": false,
  "message": "Pesan error",
  "errors": [
    {
      "field": "nama_field",
      "message": "Pesan validasi"
    }
  ]
}
```

## Kode Status HTTP

API ini menggunakan kode status HTTP standar:

- `200 OK`: Permintaan berhasil
- `201 Created`: Permintaan berhasil dan resource baru telah dibuat
- `400 Bad Request`: Permintaan tidak valid karena kesalahan sintaks atau parameter
- `401 Unauthorized`: Autentikasi diperlukan atau gagal
- `403 Forbidden`: Anda tidak memiliki izin untuk mengakses resource ini
- `404 Not Found`: Resource tidak ditemukan
- `409 Conflict`: Konflik dengan state resource saat ini
- `422 Unprocessable Entity`: Permintaan valid tetapi gagal karena validasi semantik
- `500 Internal Server Error`: Error pada sisi server

## Paginasi

Untuk endpoint yang mengembalikan banyak data, paginasi disediakan dengan parameter berikut:

- `limit`: Jumlah item per halaman (default: 20)
- `offset`: Offset dari data pertama (default: 0)

Contoh respon dengan paginasi:

```json
{
  "success": true,
  "data": {
    "items": [...],
    "total": 100,
    "limit": 20,
    "offset": 0
  }
}
```

## Format Tanggal dan Waktu

Semua tanggal dan waktu menggunakan format ISO 8601:

- Tanggal: `YYYY-MM-DD` (contoh: "2025-05-06")
- Waktu: `HH:MM:SS` (contoh: "05:00:00")
- Datetime: `YYYY-MM-DDTHH:MM:SSZ` (contoh: "2025-05-06T05:00:00Z")

## Endpoint Tersedia

- [Autentikasi dan Manajemen Akun](auth.md)
- [Manajemen Kategori](categories.md)
- [Manajemen Aktivitas Master](activity-masters.md)
- [Manajemen Instance Aktivitas](activity-instances.md)
- [Statistik Aktivitas](statistics.md)

## Batasan Rate

API ini memiliki batasan 100 permintaan per menit per IP. Header berikut akan dikembalikan dengan setiap respon:

- `X-RateLimit-Limit`: Jumlah maksimum permintaan per menit
- `X-RateLimit-Remaining`: Jumlah permintaan yang tersisa dalam jendela waktu saat ini
- `X-RateLimit-Reset`: Waktu (dalam detik) hingga batas rate dipulihkan

## Contoh Penggunaan

### Mendapatkan Token

```javascript
fetch('https://api.hirup-aing.com/v1/auth/login', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    email: 'pengguna@example.com',
    password: 'password123'
  })
})
  .then(response => response.json())
  .then(data => {
    if (data.success) {
      const token = data.data.token;
      // Simpan token untuk digunakan di permintaan berikutnya
    } else {
      console.error('Login gagal:', data.message);
    }
  });
```

### Mendapatkan Daftar Aktivitas Hari Ini

```javascript
const token = '...'; // Token yang diperoleh dari login

fetch('https://api.hirup-aing.com/v1/instances?date=2025-05-06', {
  method: 'GET',
  headers: {
    'Authorization': `Bearer ${token}`
  }
})
  .then(response => response.json())
  .then(data => {
    if (data.success) {
      const activities = data.data.instances;
      // Proses daftar aktivitas
    } else {
      console.error('Gagal mendapatkan aktivitas:', data.message);
    }
  });
```

## Penanganan Error

Sangat disarankan untuk selalu memeriksa nilai `success` pada respons untuk menentukan apakah permintaan berhasil atau tidak. Jika `success: false`, pesan error akan tersedia di properti `message` dan detail tambahan mungkin tersedia di array `errors`.