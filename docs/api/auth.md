# API Dokumentasi: Autentikasi

Base URL: `https://api.hirup-aing.com/v1` (contoh)

## Registrasi

Mendaftarkan pengguna baru.

**URL**: `/auth/register`

**Metode**: `POST`

**Auth**: Tidak Diperlukan

**Body**:

```json
{
  "email": "pengguna@example.com",
  "password": "password123",
  "name": "Nama Pengguna"
}
```

**Response Sukses**:

- **Kode**: `201 Created`
- **Content**:

```json
{
  "success": true,
  "message": "Registrasi berhasil",
  "data": {
    "id": "user-uuid",
    "email": "pengguna@example.com",
    "name": "Nama Pengguna",
    "role": "USER",
    "createdAt": "2025-05-06T08:00:00Z"
  }
}
```

**Response Error**:

- **Kode**: `400 Bad Request`
- **Content**:

```json
{
  "success": false,
  "message": "Email sudah digunakan",
  "errors": [
    {
      "field": "email",
      "message": "Email sudah terdaftar dalam sistem"
    }
  ]
}
```

## Login

Melakukan autentikasi pengguna.

**URL**: `/auth/login`

**Metode**: `POST`

**Auth**: Tidak Diperlukan

**Body**:

```json
{
  "email": "pengguna@example.com",
  "password": "password123"
}
```

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "message": "Login berhasil",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": "user-uuid",
      "email": "pengguna@example.com",
      "name": "Nama Pengguna",
      "role": "USER"
    }
  }
}
```

**Response Error**:

- **Kode**: `401 Unauthorized`
- **Content**:

```json
{
  "success": false,
  "message": "Email atau password salah"
}
```

## Refresh Token

Memperbarui token akses menggunakan refresh token.

**URL**: `/auth/refresh-token`

**Metode**: `POST`

**Auth**: Tidak Diperlukan

**Body**:

```json
{
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "message": "Token diperbarui",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

**Response Error**:

- **Kode**: `401 Unauthorized`
- **Content**:

```json
{
  "success": false,
  "message": "Refresh token tidak valid atau kadaluarsa"
}
```

## Logout

Mengakhiri sesi pengguna.

**URL**: `/auth/logout`

**Metode**: `POST`

**Auth**: Bearer Token

**Body**: Tidak diperlukan

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "message": "Logout berhasil"
}
```

## Mendapatkan Profil Pengguna

Mendapatkan informasi profil pengguna yang sedang login.

**URL**: `/auth/me`

**Metode**: `GET`

**Auth**: Bearer Token

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "data": {
    "id": "user-uuid",
    "email": "pengguna@example.com",
    "name": "Nama Pengguna",
    "role": "USER",
    "createdAt": "2025-05-06T08:00:00Z"
  }
}
```

**Response Error**:

- **Kode**: `401 Unauthorized`
- **Content**:

```json
{
  "success": false,
  "message": "Token tidak valid atau kadaluarsa"
}
```