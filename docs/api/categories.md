# API Dokumentasi: Kategori

Base URL: `https://api.hirup-aing.com/v1` (contoh)

## Mendapatkan Semua Kategori

Mendapatkan daftar kategori milik pengguna yang sedang login.

**URL**: `/categories`

**Metode**: `GET`

**Auth**: Bearer Token

**Params**:

| Nama   | Tipe   | Wajib | Deskripsi                                    |
|--------|--------|-------|----------------------------------------------|
| search | string | Tidak | Mencari kategori berdasarkan nama            |
| limit  | number | Tidak | Batas jumlah data yang dikembalikan (default: 20) |
| offset | number | Tidak | Offset untuk paginasi data (default: 0)      |

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "data": {
    "categories": [
      {
        "id": "cat-001",
        "name": "Ibadah",
        "userId": "user-uuid"
      },
      {
        "id": "cat-002",
        "name": "Kewajiban",
        "userId": "user-uuid"
      },
      {
        "id": "cat-003",
        "name": "Kesehatan",
        "userId": "user-uuid"
      }
    ],
    "total": 3,
    "limit": 20,
    "offset": 0
  }
}
```

## Mendapatkan Detail Kategori

Mendapatkan detail kategori berdasarkan ID.

**URL**: `/categories/:id`

**Metode**: `GET`

**Auth**: Bearer Token

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "data": {
    "id": "cat-001",
    "name": "Ibadah",
    "userId": "user-uuid",
    "createdAt": "2025-05-06T08:00:00Z",
    "updatedAt": "2025-05-06T08:00:00Z"
  }
}
```

**Response Error**:

- **Kode**: `404 Not Found`
- **Content**:

```json
{
  "success": false,
  "message": "Kategori tidak ditemukan"
}
```

## Membuat Kategori Baru

Membuat kategori baru untuk pengguna yang sedang login.

**URL**: `/categories`

**Metode**: `POST`

**Auth**: Bearer Token

**Body**:

```json
{
  "name": "Olahraga"
}
```

**Response Sukses**:

- **Kode**: `201 Created`
- **Content**:

```json
{
  "success": true,
  "message": "Kategori berhasil dibuat",
  "data": {
    "id": "cat-004",
    "name": "Olahraga",
    "userId": "user-uuid",
    "createdAt": "2025-05-06T09:00:00Z",
    "updatedAt": "2025-05-06T09:00:00Z"
  }
}
```

**Response Error**:

- **Kode**: `400 Bad Request`
- **Content**:

```json
{
  "success": false,
  "message": "Kategori dengan nama tersebut sudah ada",
  "errors": [
    {
      "field": "name",
      "message": "Nama kategori harus unik untuk setiap pengguna"
    }
  ]
}
```

## Memperbarui Kategori

Memperbarui nama kategori berdasarkan ID.

**URL**: `/categories/:id`

**Metode**: `PUT`

**Auth**: Bearer Token

**Body**:

```json
{
  "name": "Olahraga Rutin"
}
```

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "message": "Kategori berhasil diperbarui",
  "data": {
    "id": "cat-004",
    "name": "Olahraga Rutin",
    "userId": "user-uuid",
    "updatedAt": "2025-05-06T10:00:00Z"
  }
}
```

**Response Error**:

- **Kode**: `404 Not Found`
- **Content**:

```json
{
  "success": false,
  "message": "Kategori tidak ditemukan"
}
```

## Menghapus Kategori

Menghapus kategori berdasarkan ID.

**URL**: `/categories/:id`

**Metode**: `DELETE`

**Auth**: Bearer Token

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "message": "Kategori berhasil dihapus"
}
```

**Response Error**:

- **Kode**: `404 Not Found`
- **Content**:

```json
{
  "success": false,
  "message": "Kategori tidak ditemukan"
}
```

- **Kode**: `409 Conflict`
- **Content**:

```json
{
  "success": false,
  "message": "Kategori sedang digunakan oleh aktivitas",
  "data": {
    "activityCount": 5
  }
}
```

## Mendapatkan Aktivitas yang Menggunakan Kategori

Mendapatkan daftar aktivitas yang menggunakan kategori tertentu.

**URL**: `/categories/:id/activities`

**Metode**: `GET`

**Auth**: Bearer Token

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "data": {
    "activities": [
      {
        "id": "act-001",
        "name": "Push Up Pagi",
        "description": null,
        "startTime": "05:11:00",
        "endTime": "05:15:00",
        "isRecurring": true,
        "frequency": "DAILY"
      },
      {
        "id": "act-003",
        "name": "Renang",
        "description": null,
        "startTime": "06:00:00",
        "endTime": "07:00:00",
        "isRecurring": true,
        "frequency": "MONTHLY"
      }
    ],
    "total": 2
  }
}
```